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
    deduct(PENALTY_FARE)
    create_entry_station_journey(station)
    input_journey_into_journey_history(create_entry_station_journey(station))
    true
  end

  def touch_out(station)
    if empty? || journey_history.last.exit_station != ""
      deduct(PENALTY_FARE)
      create_exit_station_journey(station)
      return input_journey_into_journey_history(create_exit_station_journey(station))
    end
    reimburse_penalty
    set_exit_station(station)
    true
  end
  private
  def deduct(amount)
    @money -= amount
    true
  end
  def empty?
    @journey_history.empty?
  end
  def input_journey_into_journey_history(journey) # Extract this method out
    @journey_history << journey
  end
  def create_exit_station_journey(station)
    journey = Journey.new
    journey.exit_station = station.name
    journey
  end # Extract this method out
  def create_entry_station_journey(station)
    journey = Journey.new
    journey.entry_station = station.name
    journey
  end # Extract this method out
  def set_exit_station(station)
    @journey_history.last.exit_station = station.name
  end # Do we need to extract this out?
  def reimburse_penalty
    @money += (PENALTY_FARE - JOURNEY_VALUE)
  end
end
