require 'journey_log'
describe JourneyLog do
  let(:journey_log) {JourneyLog.new}
  it "creates an instance of JourneyLog" do
    expect(journey_log.instance_of? JourneyLog).to eq true
  end
  it "initializes journey_history to empty array" do
    expect(journey_log.journey_history).to eq []
  end
  it "initializes current_journey to nil" do
    expect(journey_log.current_journey).to eq nil
  end
end
