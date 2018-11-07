require 'journey'
describe Journey do
  let(:journey) {Journey.new}
  it "creates a journey instance" do
    expect(journey.instance_of? Journey).to eq true    
  end
end
