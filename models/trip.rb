# frozen_string_literal: true

class Trip
  attr_reader :start_time, :end_time, :miles

  def initialize(start_time:, end_time:, miles:)
    @start_time = raw_time(start_time)
    @end_time = raw_time(end_time)
    @miles = miles.to_f
  end

  def duration
    end_time - start_time
  end

  def speed
    miles / duration
  end

  private

  def raw_time(string_time)
    hours, minutes = string_time.split(":")
    hours.to_f + (minutes.to_f / 60)
  end
end
