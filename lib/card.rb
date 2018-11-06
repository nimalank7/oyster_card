class Card
  attr_accessor :money
  def initialize
    @money = 0
  end
  CAPACITY = 500

  def add_money(amount)
    temp_money = @money + amount
    if temp_money <= CAPACITY
      @money = temp_money
      return puts "Added #{amount}"
    end
    raise ("Error capacity of #{CAPACITY} reached")
  end
  def journey
    @money -= 100
    puts "journey paid for"
  end
end
