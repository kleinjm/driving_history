Dir["./models/*.rb"].each { |file| require file }

# Discard any trips that average a speed of less than 5 mph or greater than 100 mph.
#
# Generate a report containing each driver with total miles driven and average speed. Sort the output by most miles driven to least. Round miles and miles per hour to the nearest integer.

class DriverReport
  def initialize(filepath:)
    @filepath = filepath
    @drivers = []
    @report = ""
  end

  def generate
    commands.each do |command|
      if command.match?(/^Driver/)
        driver_name = command.split(" ")[1]
        driver = Driver.new(name: driver_name)
        @drivers << driver unless @drivers.any? { |d| d.name == driver_name }
      elsif command.match?(/^Trip/)
        driver_name, start_time, end_time, miles = command.split(" ")[1..-1]
        driver = @drivers.find { |reg_driver| reg_driver.name == driver_name }
        next if driver.nil? # driver not registered

        driver.trips << Trip.new(start_time: start_time, end_time: end_time, miles: miles)
      else
        raise ArgumentError, "Invalid command in input file"
      end
    end

    @drivers.sort.each do |driver|
      @report << "#{driver.trip_report}\n"
    end
    @report.strip
  end

  private

  COMMAND_DELIMITER = "\n".freeze
  private_constant :COMMAND_DELIMITER

  attr_reader :filepath

  # if this method were called more than once, I'd memoize it
  def commands
    File.open(filepath).read.split(COMMAND_DELIMITER)
  end
end
