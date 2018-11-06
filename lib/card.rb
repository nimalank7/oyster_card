require_relative "./station.rb"
=begin
get the entry_station value
get the exit_station value
put that into a hash
push the hash into the journey_history instance variable (array)
journey_history << {start_station => entry_station, end_station => exit_station}
=end
class Card
  attr_accessor :money
  attr_reader :entry_station, :exit_station, :journey_history
  CAPACITY = 500
  JOURNEY_VALUE = 100
  def initialize
    @money = 0
    @entry_station, @exit_station = nil
    @journey_history = []
  end
  
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
    @entry_station = station.name
    true
  end

  def touch_out(station)
    if in_journey? == false
      raise("You've touched out already!")
    end
    @exit_station = station.name
    record_journey
    @entry_station = nil
    journey
    true
  end
  def in_journey?
    entry_station == nil ? false : true
  end
  private
  def journey
    @money -= JOURNEY_VALUE
    puts "journey paid for"
  end
  def record_journey
    journey_history << {:entry_station => @entry_station, :exit_station => @exit_station}
  end
end
