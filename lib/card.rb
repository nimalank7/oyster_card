class Card
  attr_accessor :money
  attr_reader :injourney
  def initialize
    @money = 0
    @injourney = false
  end
  CAPACITY = 500
  JOURNEY_VALUE = 100

  def add_money(amount)
    temp_money = @money + amount
    if temp_money <= CAPACITY
      @money = temp_money
      return puts "Added #{amount}"
    end
    raise ("Error capacity of #{CAPACITY} reached")
  end
  def journey
    raise("You do not have enough funds") if money < JOURNEY_VALUE
    @money -= JOURNEY_VALUE
    puts "journey paid for"
  end
  def touch_in
    if @injourney == true
      raise("You've touched in already!")
    end
    @injourney = true
    true
  end
  def touch_out
    if @injourney == false
      raise("You've touched out already!")
    end
    @injourney = false
    true
  end
end
