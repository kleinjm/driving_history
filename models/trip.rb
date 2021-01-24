# frozen_string_literal: true

class Trip
  attr_reader :driver, :start_time, :end_time, :miles_driven

  def initialize(driver:, start_time:, end_time:, miles_driven:)
    @driver = driver
    @start_time = start_time
    @end_time = end_time
    @miles_driven = miles_driven
  end
end
