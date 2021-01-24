# frozen_string_literal: true

require "./driver_report"

RSpec.describe DriverReport do
  describe "#generate" do
    it "can handle multiple registrations" do
      report = DriverReport.new(filepath: "./example_inputs/multiple_registrations.txt").generate

      expected_output = "Lauren: 0 miles\nKumi: 0 miles"
      expect(report).to eq(expected_output)
    end

    it "can handle trips without registered drivers" do
      report = DriverReport.new(filepath: "./example_inputs/not_registered.txt").generate

      expect(report).to eq("")
    end

    it "generates a typical report" do
      report = DriverReport.new(filepath: "./example_inputs/problem_statement.txt").generate

      expected_output = <<~STRING
        Lauren: 42 miles @ 34 mph
        Dan: 39 miles @ 47 mph
        Kumi: 0 miles
      STRING
      expect(report).to eq(expected_output.strip)
    end

    it "returns the expected number of drivers for large datasets" do
      report = DriverReport.new(filepath: "./example_inputs/large_dataset_50.txt").generate

      expect(report.split("\n").count).to eq(50)
    end

    it "filters out trips that are too fast or slow" do
      report = DriverReport.new(filepath: "./example_inputs/too_fast_or_slow.txt").generate

      expected_output = "Dan: 30 miles @ 30 mph"
      expect(report).to eq(expected_output)
    end
  end
end
