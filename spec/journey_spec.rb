require 'journey'
describe Journey do
  let(:journey) {Journey.new}
  it "creates a journey instance" do
    expect(journey.instance_of? Journey).to eq true
  end
  it "initialises entry_station to empty string" do
    expect(journey.entry_station).to eq ""
  end
  it "initialises exit_station to empty string" do
    expect(journey.exit_station).to eq ""
  end
  it "initialises entry_station_zone to 0" do
    expect(journey.entry_station_zone).to eq 0
  end
  it "initialises exit_station_zone to 0" do
    expect(journey.exit_station_zone).to eq 0
  end

end
