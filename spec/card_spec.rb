require 'card'
require 'station'
describe Card do
  let(:card) {card = Card.new}
  let(:station) {station = Station.new}
  let(:station_2) {station = Station.new}

  it "Money on card displays 0" do
    expect(card.money).to eq 0
  end
  it "adds 100 to the total" do
    card.add_money(100)
    expect(card.money).to eq 100
  end
  it "throws an error if added more money than current total" do
    card.money = 490
    expect{card.add_money(100)}.to raise_error("Error capacity of #{Card::CAPACITY} reached")
  end
  it "returns 500 for capacity" do
    expect(Card::CAPACITY).to eq(500)
  end
  it "returns false for default" do
    expect(card.in_journey?).to eq false
  end
  it "touches in changes status in journey to true" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    expect(card.in_journey?).to eq true
  end
  it "touches out changes status in journey to false" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    card.touch_out(station)
    expect(card.in_journey?).to eq false
  end # Done up to here
  it "touching in 2x returns an error" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    expect{card.touch_in(station)}.to raise_error("You've touched in already!")
  end
  it "touching out 2x returns an error" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    card.touch_out(station)
    expect{card.touch_out(station)}.to raise_error("You've touched out already!")
  end
  it "cannot travel without min funds" do
    expect{card.touch_in(station)}.to raise_error ("You do not have enough funds")
  end
  it "correct amount deducted" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    expect{card.touch_out(station)}.to change{card.money}.from(400).to(300)
  end
  it "displays true if injourney" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    expect(card.in_journey?).to eq true
  end
  it "displays false if not injourney" do
    card.money = 400
    station.name = "Euston"
    card.touch_in(station)
    card.touch_out(station)
    expect(card.in_journey?).to eq false
  end
  it "displays entry station as nil" do
    expect(card.entry_station).to eq (nil)
  end
  it "display exit station as nil when initialized" do
    expect(card.exit_station).to eq nil
  end
  it "displays exit station as Blackfriars" do
    card.money = 400
    station.name = "Euston"
    station_2.name = "Blackfriars"
    card.touch_in(station)
    card.touch_out(station_2)
    expect(card.exit_station).to eq "Blackfriars"
  end
  it "displays journey_history as empty array" do
    expect(card.journey_history.empty?).to eq true
  end
  it "checks if Euston-BlackFriars is in journey_history" do
    card.money = 400
    station.name = "Euston"
    station_2.name = "Blackfriars"
    card.touch_in(station)
    card.touch_out(station_2)
    expect(card.journey_history.include? {"entry_station" => "Euston","exit_station" => "Blackfriars"}).to eq true
  end
end
