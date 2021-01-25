# frozen_string_literal: true

class Trip
  attr_reader :miles

  def initialize(start_time:, end_time:, miles:)
    @start_time = raw_time(time: start_time)
    @end_time = raw_time(time: end_time)
    @miles = miles.to_f
  end

  def duration
    (end_time - start_time).round(2)
  end

  def speed
    miles / duration
  end

  private

  attr_reader :start_time, :end_time

  def raw_time(time:)
    hours, minutes = time.split(":")
    hours.to_f + (minutes.to_f / 60)
  end
end
