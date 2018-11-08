require 'journey_log'
require 'journey.rb'

describe JourneyLog do
  let(:journey_log) {JourneyLog.new}
  let(:journey_1) {double :journey_1}
  let(:station_1) {double :station_1}
  let(:station_2) {double :station_2}
  before(:each) do
    allow(station_1).to receive(:name).and_return("Euston")
    allow(station_2).to receive(:name).and_return("")
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
  it "get_current_journey returns the journey when touched in" do
    journey_log.start(station_1)
    current_journey = journey_log.current_journey
    expect(journey_log.get_current_journey).to eq current_journey
  end
  it "start returns true" do
    expect(journey_log.start(station_1)).to eq true
  end

end
