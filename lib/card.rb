class Card
  attr_accessor :money
  attr_reader :injourney, :entry_station
  def initialize
    @money = 0
    @injourney = false
    @entry_station = nil
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

  def touch_in(station)
    raise("You do not have enough funds") if money < JOURNEY_VALUE
    raise("You've touched in already!") if in_journey?
    @injourney = true # Code goes here
    @entry_station = station.name
    true
  end

  def touch_out(station)
    if in_journey? == false
      raise("You've touched out already!")
    end
    @injourney = false
    @entry_station = nil
    journey
    true
  end
  def in_journey?
    entry_station == nil ? false : true
  end
  private def journey
    @money -= JOURNEY_VALUE
    puts "journey paid for"
  end
end
