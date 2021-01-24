require "./command_parser"
require "./utils/pluralize"

class AllDriversReport
  def initialize(filepath:)
    @filepath = filepath
  end

  def generate
    drivers = CommandParser.new(commands: commands).parse
    build_report(drivers: drivers)
  end

  private

  COMMAND_DELIMITER = "\n".freeze
  private_constant :COMMAND_DELIMITER

  attr_reader :filepath

  def commands
    File.open(filepath).read.split(COMMAND_DELIMITER)
  end

  def build_report(drivers:)
    report = ""
    drivers.sort.each do |driver|
      report << driver_report(driver: driver) + "\n"
    end
    report.strip
  end

  def driver_report(driver:)
    report = "#{driver.name}: #{pluralize(driver.total_miles.round, 'mile')}"
    report += " @ #{driver.average_speed} mph" if driver.average_speed.positive?
    report
  end
end
