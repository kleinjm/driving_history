# frozen_string_literal: true

Dir["./models/*.rb"].each { |file| require file }

# given a list of string commands, returns a list of Drivers and their
# related trips
#
# ie. [<Driver name: "Dan", trips: [<Trip miles: 12.9 ... >, <Trip ...>], ...]
class CommandParser
  def initialize(commands:)
    @commands = commands
  end

  def parse
    drivers = []

    commands.each do |command|
      if command.match?(DRIVER_COMMAND)
        register_driver(command: command, drivers: drivers)
      elsif command.match?(TRIP_COMMAND)
        add_trip(command: command, drivers: drivers)
      else
        raise ArgumentError, "Invalid command"
      end
    end

    drivers
  end

  private

  DRIVER_COMMAND = Regexp.new(/^Driver/)
  TRIP_COMMAND = Regexp.new(/^Trip/)
  private_constant :DRIVER_COMMAND, :TRIP_COMMAND

  attr_reader :commands

  def register_driver(command:, drivers:)
    driver_name = command.split(" ")[1]
    driver = Driver.new(name: driver_name)

    drivers << driver unless drivers.any? { |d| d.name == driver_name }
  end

  # Add Trip to Driver#trips. If Driver not found in registered drivers,
  # fail silently.
  def add_trip(command:, drivers:)
    driver_name, start_time, end_time, miles = command.split(" ")[1..-1]
    driver = drivers.find { |reg_driver| reg_driver.name == driver_name }
    return if driver.nil? # driver not registered

    driver.trips << Trip.new(
      start_time: start_time, end_time: end_time, miles: miles
    )
  end
end
