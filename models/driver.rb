# frozen_string_literal: true

require "./utils/pluralize"

class Driver
  include Comparable

  attr_reader :name
  attr_accessor :trips

  def initialize(name:)
    @name = name
    @trips = []
  end

  def <=>(other_driver)
    other_driver.total_miles <=> total_miles
  end

  def trip_report
    average_speed = (total_time.zero? ? 0 : total_miles / total_time).round

    report = "#{name}: #{pluralize(total_miles.round, 'mile')}"
    report += " @ #{average_speed} mph" if average_speed.positive?
    report
  end

  def total_miles
    @total_miles || compute_trip_stats[:total_miles] || 0
  end

  def total_time
    @total_time || compute_trip_stats[:total_time] || 0
  end

  private

  SLOW_LIMIT = 5
  FAST_LIMIT = 100

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
