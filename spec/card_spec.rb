require 'card'
describe Card do
  let(:card) {card = Card.new}
  it "creates instance of Card class" do
    expect(card.instance_of? Card).to eq true
  end
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
end
