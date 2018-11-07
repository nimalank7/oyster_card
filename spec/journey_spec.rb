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
end
