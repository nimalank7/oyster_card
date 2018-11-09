require_relative "./station.rb"
require_relative "./journey.rb"
require_relative "./journey_log.rb"

class Card
  attr_accessor :money
  MAXIMUM_VALUE = 500
  MINIMUM_JOURNEY_VALUE = 100
  PENALTY_FARE = 200
  def initialize
    @money = 0
    @journey_log = JourneyLog.new
  end

  def add_money(amount)
    if @money + amount < MAXIMUM_VALUE
      @money += amount
      return puts "Added #{amount}"
    end
    raise ("Error capacity of #{MAXIMUM_VALUE} reached")
  end

  def touch_in(station)
    raise("You do not have enough funds") if money < MINIMUM_JOURNEY_VALUE
    deduct(PENALTY_FARE)
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    @journey_log.show_all_journeys.last.entry_station == "" ? deduct(PENALTY_FARE) : reimburse_penalty
    true
  end
  private
  def deduct(amount)
    @money -= amount
    true
  end

  def reimburse_penalty
    @money += (PENALTY_FARE - MINIMUM_JOURNEY_VALUE)
  end
end
=begin
for zone fares
we need to take the absolute value of the zone difference
then add 1 to it
we'll have to modify our touch out method
to take account of this
=end
