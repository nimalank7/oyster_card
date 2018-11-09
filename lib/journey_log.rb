require_relative "./journey.rb"
require_relative "./station.rb"


class JourneyLog
  attr_reader :journey_history, :current_journey
  def initialize
    @journey_history = []
    @current_journey = nil
  end
  def start(station)
    get_current_journey
    @current_journey.entry_station = station.name # Penalty fare is in the oyster touch in
    @journey_history << @current_journey
    true
  end
  def get_current_journey
    @current_journey ||= Journey.new
  end
  def finish(station)
    if @current_journey == nil
      get_current_journey
      @current_journey.exit_station = station.name
      @journey_history << @current_journey
      @current_journey = nil
      return true
    end
    get_current_journey
    @current_journey.exit_station = station.name
    @current_journey = nil
    true
  end
end
=begin

for zone fares
we need to take the absolute value of the zone difference
then add 1 to it

we'll have to modify our touch out method
to take account of this
=end
