require 'card'
require 'station'
require 'journey'
describe Card do
  let(:card) {card = Card.new}
  let(:station_1) {double :station_1}
  let(:station_2) {double :station_2}
  let(:station_3) {double :station_3}
  let(:station_4) {double :station_4}
  let(:station_5) {double :station_5}
  let(:station_6) {double :station_6}
  before(:each) do
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    allow(station_1).to receive_messages(:zone= => 1, :zone => 1)
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
    allow(station_2).to receive_messages(:zone= => 1, :zone => 1)
    allow(station_3).to receive_messages(:name= => "Arsenal", :name => "Arsenal")
    allow(station_3).to receive_messages(:zone= => 2, :zone => 2)
    allow(station_4).to receive_messages(:name= => "Beckton", :name => "Beckton")
    allow(station_4).to receive_messages(:zone= => 3, :zone => 3)
    allow(station_5).to receive_messages(:name= => "East Croydon", :name => "East Croydon")
    allow(station_5).to receive_messages(:zone= => 6, :zone => 6)
  end
  it "adds 100 to the total" do
    card.add_money(100)
    expect(card.money).to eq 100
  end
  it "throws an error if added more money than current total" do
    card.money = 490
    expect{card.add_money(100)}.to raise_error("Error capacity of #{Card::MAXIMUM_VALUE} reached")
  end
  it "returns 500 for capacity" do
    expect(Card::MAXIMUM_VALUE).to eq(500)
  end
  it "returns 100 for minimum journey value" do
    expect(Card::MINIMUM_JOURNEY_VALUE).to eq(100)
  end

  it "cannot travel without min funds" do
    expect{card.touch_in(station_1)}.to raise_error ("You do not have enough funds")
  end
  it "penalty fare is 200" do
    expect(Card::PENALTY_FARE).to eq 200
  end
  it "deducts penalty fare if we don't touch in but touch out" do
    card.money = 400
    expect{ card.touch_out(station_2)}.to change{ card.money }.by(-Card::PENALTY_FARE)
  end
  it "deducts penalty fare if we don't touch out but touch in" do
    card.money = 400
    expect{ card.touch_in(station_1)}.to change{ card.money }.by(-Card::PENALTY_FARE)
  end
  it "returns true when touching in" do
    card.money = 400
    expect(card.touch_in(station_1)).to eq true
  end
  it "returns true when touching out" do
    card.money = 400
    card.touch_in(station_1)
    expect(card.touch_out(station_2)).to eq true
  end
  it "deducts 100 for a journey in the same zones" do
    card.money = 400
    card.touch_in(station_1)
    expect{ card.touch_out(station_2)}.to change{ card.money }.by(+Card::MINIMUM_JOURNEY_VALUE)
  end
  it "deducts 200 for journey from zones 1 to 2" do
    card.money = 400
    card.touch_in(station_1)
    expect{ card.touch_out(station_3)}.to change{ card.money }.by(0)
  end
  it "deducts 400 for journey from zones 3 to 6" do
    card.money = 400
    card.touch_in(station_4)
    expect{ card.touch_out(station_5)}.to change{ card.money }.by(-200)
  end
end
