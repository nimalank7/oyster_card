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
    expect(journey_log.show_all_journeys).to eq []
  end
  it "stores incomplete journeys when we don't touch out" do
    entry_station_only = []
    journey_log.start(station_1)
    entry_station_only << journey_log.show_all_journeys[0].entry_station
    entry_station_only << journey_log.show_all_journeys[0].exit_station
    expect(entry_station_only).to eq ["Euston", ""]
  end
  it "stores an incomplete journey when we don't touch in" do
    exit_station_only = []
    journey_log.finish(station_2)
    exit_station_only << journey_log.show_all_journeys[0].entry_station
    exit_station_only << journey_log.show_all_journeys[0].exit_station
    expect(exit_station_only).to eq ["", "Blackfriars"]
  end
  it "presents all journeys and checks whether Euston-Blackfriars is in journey_history" do
    journey_log.start(station_1)
    journey_log.finish(station_2)
    entry_and_exit_stations = []
    entry_and_exit_stations << journey_log.show_all_journeys[0].entry_station
    entry_and_exit_stations << journey_log.show_all_journeys[0].exit_station
    expect(entry_and_exit_stations).to eq ["Euston", "Blackfriars"]
  end
end
