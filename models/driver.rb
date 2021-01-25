# frozen_string_literal: true

require "./models/trip_stats"
require "forwardable"

class Driver
  extend Forwardable

  attr_reader :name, :trips

  def_delegators :trip_stats, :total_time, :total_miles, :average_speed

  def initialize(name:)
    @name = name
    @trips = []
  end

  def <=>(other_driver)
    other_driver.total_miles <=> total_miles
  end

  private

  def trip_stats
    @trip_stats ||= TripStats.new(trips: trips)
  end
end
