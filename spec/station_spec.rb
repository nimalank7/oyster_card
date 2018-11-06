require 'station'

describe Station do
  let(:station) {station = Station.new}
  it 'checks if station is Euston' do
    station.name = "Euston"
    expect(station.name).to eq("Euston")
  end
  it "displays the zone the station is in" do
    station.zone = 2
    expect(station.zone).to eq 2
  end
end
