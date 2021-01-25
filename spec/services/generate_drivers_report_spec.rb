# frozen_string_literal: true

require "./services/generate_drivers_report"

RSpec.describe GenerateDriversReport do
  describe "#generate" do
    it "can handle multiple registrations" do
      expected_output = "Lauren: 0 miles\nKumi: 0 miles"

      expect(report_for("multiple_registrations")).to eq(expected_output)
    end

    it "can handle trips without registered drivers" do
      expect(report_for("not_registered")).to eq("")
    end

    it "generates a typical report" do
      expected_output = <<~STRING
        Lauren: 42 miles @ 34 mph
        Dan: 39 miles @ 47 mph
        Kumi: 0 miles
      STRING

      expect(report_for("problem_statement")).to eq(expected_output.strip)
    end

    it "returns the expected number of drivers for large datasets" do
      expect(report_for("large_dataset_50").split("\n").count).to eq(50)
    end

    it "filters out trips that are too fast or slow" do
      expect(report_for("too_fast_or_slow")).to eq("Dan: 30 miles @ 30 mph")
    end

    it "handles invalid commands" do
      expect { report_for("invalid_commands") }.
        to raise_error(ArgumentError, "Invalid command")
    end
  end

  def report_for(filename)
    filepath = "./example_inputs/#{filename}.txt"
    GenerateDriversReport.new(filepath: filepath).generate
  end
end
