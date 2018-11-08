require 'journey_log'
require 'journey.rb'

describe JourneyLog do
  let(:journey_log) {JourneyLog.new}
  let(:journey_1) {double :journey_1}
  let(:station_1) {double :station_1}
  let(:station_2) {double :station_2}
  before(:each) do
    allow(station_1).to receive(:name).and_return("Euston")
    allow(station_2).to receive(:name).and_return("Blackfriars")
  end
  it "initializes journey_history to empty array" do
    expect(journey_log.journey_history).to eq []
  end
  it "initializes current_journey to nil" do
    expect(journey_log.current_journey).to eq nil
  end
  it "stores incomplete journeys when we don't touch out" do
    entry_station_only = []
    journey_log.start(station_1)
    entry_station_only << journey_log.journey_history[0].entry_station
    entry_station_only << journey_log.journey_history[0].exit_station
    expect(entry_station_only).to eq ["Euston", ""]
  end
  it "stores an incomplete journey when we don't touch in" do
    exit_station_only = []
    journey_log.finish(station_2)
    exit_station_only << journey_log.journey_history[0].entry_station
    exit_station_only << journey_log.journey_history[0].exit_station
    expect(exit_station_only).to eq ["", "Blackfriars"]
  end
  it "get_current_journey returns the journey when touched in" do
    journey_log.start(station_1)
    current_journey = journey_log.current_journey
    expect(journey_log.get_current_journey).to eq current_journey
  end
  it "checks whether Euston-Blackfriars is in journey_history" do
    journey_log.start(station_1)
    journey_log.finish(station_2)
    entry_and_exit_stations = []
    entry_and_exit_stations << journey_log.journey_history[0].entry_station
    entry_and_exit_stations << journey_log.journey_history[0].exit_station
    expect(entry_and_exit_stations).to eq ["Euston", "Blackfriars"]
  end


end
