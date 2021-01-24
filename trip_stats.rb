# frozen_string_literal: true

class TripStats
  def initialize(trips:)
    @trips = trips
  end

  def total_miles
    @total_miles ||= compute_trip_stats[:total_miles] || 0
  end

  def total_time
    @total_time ||= compute_trip_stats[:total_time] || 0
  end

  private

  attr_reader :trips

  SLOW_LIMIT = 5
  FAST_LIMIT = 100
  private_constant :SLOW_LIMIT, :FAST_LIMIT

  def compute_trip_stats
    @total_miles = 0
    @total_time = 0

    trips.each do |trip|
      next if trip.speed < SLOW_LIMIT || trip.speed > FAST_LIMIT

      @total_miles += trip.miles
      @total_time += trip.duration
    end

    { total_miles: @total_miles, total_time: @total_time }
  end
end
