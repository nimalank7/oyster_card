require_relative "./station.rb"
class Card
  attr_accessor :money
  attr_reader :entry_station, :exit_station, :journey_history
  CAPACITY = 500
  JOURNEY_VALUE = 100
  PENALTY_FARE = 200
  def initialize
    @money = 0
    @entry_station, @exit_station = nil
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
    deduct(PENALTY_FARE)
    @entry_station = station.name
    @journey_history << {:entry_station => @entry_station}
    true
  end

  def touch_out(station)
    @exit_station = station.name
    if empty? || @entry_station == nil
      deduct(PENALTY_FARE)
      return @journey_history << {:exit_station => @exit_station}
    end
    @money += (PENALTY_FARE - JOURNEY_VALUE)
    @journey_history.last[:exit_station] = @exit_station
    @entry_station = nil
    true
  end
  def in_journey?
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
