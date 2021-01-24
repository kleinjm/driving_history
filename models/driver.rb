# frozen_string_literal: true

require "./models/trip_stats"

class Driver
  attr_reader :name, :trips

  def initialize(name:)
    @name = name
    @trips = []
  end

  def <=>(other_driver)
    other_driver.total_miles <=> total_miles
  end

  def total_miles
    trip_stats.total_miles
  end

  def total_time
    trip_stats.total_time
  end

  def average_speed
    @average_speed ||= (total_time.zero? ? 0 : total_miles / total_time).round
  end

  private

  def trip_stats
    @trip_stats ||= TripStats.new(trips: trips)
  end
end
