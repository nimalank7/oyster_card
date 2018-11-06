require 'card'
describe Card do
  let(:card) {card = Card.new}
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
  it "deducts journey" do
    card.money = 400
    card.journey()
    expect(card.money).to eq(300)
  end
  it "returns false for default" do
    expect(card.injourney).to eq false
  end
  it "touches in changes status in journey to true" do
    card.touch_in
    expect(card.injourney).to eq true
  end
  it "touches out changes status in journey to false" do
    card.touch_in
    card.touch_out
    expect(card.injourney).to eq false
  end # Done up to here
  it "touching in 2x returns an error" do
    card.touch_in
    expect{card.touch_in}.to raise_error("You've touched in already!")
  end
  it "touching out 2x returns an error" do
    card.touch_in
    card.touch_out
    expect{card.touch_out}.to raise_error("You've touched out already!")
  end
end
