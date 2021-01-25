# frozen_string_literal: true

require "./models/trip"

RSpec.describe Trip do
  describe "#duration" do
    it "returns the expected duration" do
      [
        { start_time: "07:00", end_time: "08:00", duration: 1 },
        { start_time: "12:00", end_time: "16:00", duration: 4 },
        { start_time: "07:00", end_time: "08:15", duration: 1.25 },
        { start_time: "03:13", end_time: "9:47", duration: 6.57 },
      ].each do |example|
        trip = Trip.new(
          start_time: example[:start_time],
          end_time: example[:end_time],
          miles: 1
        )
        expect(trip.duration).to eq(example[:duration])
      end
    end
  end

  describe "#speed" do
    it "returns the expected speed" do
      expect(Trip.new(start_time: "07:00", end_time: "08:00", miles: 30).speed).
        to eq(30)

      expect(Trip.new(start_time: "07:00", end_time: "09:00", miles: 30).speed).
        to eq(15)

      expect(Trip.new(start_time: "07:00", end_time: "08:15", miles: 52).speed).
        to eq(41.6)
    end
  end
end
