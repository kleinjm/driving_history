# frozen_string_literal: true

# Driver Dan
# Driver Lauren
# Driver Kumi
# Trip Dan 07:15 07:45 17.3
# Trip Dan 06:12 06:32 21.8
# Trip Lauren 12:01 13:16 42.0#

require "./models/driver"
require "./models/trip"
require "faker"

File.open("example_inputs/large_dataset.txt", "w") do |file|
  50.times do
    driver = Driver.new(name: Faker::Name.first_name)
    file << "Driver #{driver.name}\n"

    trip_count = rand(0..9)
    trip_count.times do
      start_time_hour = rand(1..12).to_s.rjust(2, "0")
      start_time_min = rand(0..59).to_s.rjust(2, "0")

      end_time_hour = rand(13..24).to_s.rjust(2, "0")
      end_time_min = rand(0..59).to_s.rjust(2, "0")
      miles_driven = rand(1.0..100.0).round(1)

      file << "Trip #{driver.name} #{start_time_hour}:#{start_time_min} #{end_time_hour}:#{end_time_min} #{miles_driven}\n"
    end
  end
end
