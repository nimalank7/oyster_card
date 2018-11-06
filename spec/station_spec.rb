require 'station'

describe Station do
  let(:station) {station = Station.new}
  it 'checs if station is Euston' do
    station.name = "Euston"
    expect(station.name).to eq("Euston")
  end
end
