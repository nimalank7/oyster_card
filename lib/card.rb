require_relative "./station.rb"
require_relative "./journey.rb"

class Card
  attr_accessor :money
  attr_reader :entry_station, :exit_station, :journey_history
  CAPACITY = 500
  JOURNEY_VALUE = 100
  PENALTY_FARE = 200
  def initialize
    @money = 0
    @journey_history = []
  end

  def add_money(amount)
    if @money + amount < CAPACITY
      @money += amount
      return puts "Added #{amount}"
    end
    raise ("Error capacity of #{CAPACITY} reached")
  end

  def touch_in(station)
    raise("You do not have enough funds") if money < JOURNEY_VALUE
    journey = Journey.new
    deduct(PENALTY_FARE)
    journey.entry_station = station.name
    @journey_history << journey
    true
  end

  def touch_out(station)
    journey = Journey.new
    journey.exit_station = station.name
    if empty? || journey_history.last.exit_station != ""
      deduct(PENALTY_FARE)
      return @journey_history << journey
    end
    @money += (PENALTY_FARE - JOURNEY_VALUE)
    @journey_history.last.exit_station = station.name
    true
  end
  def in_journey? # This method is redundant
    entry_station == nil ? false : true
  end
  private
  def deduct(amount)
    @money -= amount
    true
  end
  def empty?
    @journey_history.empty?
  end
end
