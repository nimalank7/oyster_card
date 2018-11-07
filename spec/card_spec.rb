require 'card'
require 'station'
describe Card do
  let(:card) {card = Card.new}
  let(:station_1) {double :station_1}
  let(:station_2) {double :station_2}

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
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    expect(card.in_journey?).to eq true
  end
  it "touches out changes status in journey to false" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    card.touch_out(station_1)
    expect(card.in_journey?).to eq false
  end
  it "cannot travel without min funds" do
    expect{card.touch_in(station_1)}.to raise_error ("You do not have enough funds")
  end
  it "correct amount deducted" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    expect{card.touch_out(station_1)}.to change{card.money}.from(200).to(300)
  end
  it "displays true if injourney" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    expect(card.in_journey?).to eq true
  end
  it "displays false if not injourney" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    card.touch_out(station_1)
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
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
    card.touch_in(station_1)
    card.touch_out(station_2)
    expect(card.exit_station).to eq "Blackfriars"
  end
  it "displays journey_history as empty array" do
    expect(card.journey_history.empty?).to eq true
  end
  it "checks if Euston-BlackFriars is in journey_history" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
    card.touch_in(station_1)
    card.touch_out(station_2)
    hash = {:entry_station => "Euston", :exit_station => "Blackfriars"}
    expect(card.journey_history.include? hash).to eq true
  end
  it "penalty fare is 200" do
    expect(Card::PENALTY_FARE).to eq 200
  end
  it "stores incomplete journeys when we don't touch in" do
    card.money = 400
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
    card.touch_out(station_2)
    hash = {:exit_station => "Blackfriars"}
    expect(card.journey_history.include? hash).to eq true
  end
  it "stores incomplete journeys when we don't touch out" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    card.touch_in(station_1)
    hash = {:entry_station => "Euston"}
    expect(card.journey_history.include? hash).to eq true
  end
  it "deducts penalty fare if we don't touch in but touch out" do
    card.money = 400
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
    expect{ card.touch_out(station_2)}.to change{ card.money }.by(-Card::PENALTY_FARE)
  end
  it "deducts penalty fare if we don't touch out but touch in" do
    card.money = 400
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    expect{ card.touch_in(station_1)}.to change{ card.money }.by(-Card::PENALTY_FARE)
  end
end
