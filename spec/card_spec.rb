require 'card'
require 'station'
require 'journey'
describe Card do
  let(:card) {card = Card.new}
  let(:station_1) {double :station_1}
  let(:station_2) {double :station_2}
  before(:each) do
    allow(station_1).to receive_messages(:name= => "Euston", :name => "Euston")
    allow(station_2).to receive_messages(:name= => "Blackfriars", :name => "Blackfriars")
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

  it "cannot travel without min funds" do
    expect{card.touch_in(station_1)}.to raise_error ("You do not have enough funds")
  end
  it "correct amount deducted" do
    card.money = 400
    card.touch_in(station_1)
    expect{card.touch_out(station_1)}.to change{card.money}.from(200).to(300)
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
end
