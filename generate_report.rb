# frozen_string_literal: true

require "./services/generate_drivers_report"

filepath = ARGV.first
raise ArgumentError, "No filepath argument provided" if filepath.nil?

puts GenerateDriversReport.new(filepath: filepath).generate
