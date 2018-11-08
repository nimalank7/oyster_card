require_relative "./journey.rb"
class JourneyLog
  attr_reader :journey_history, :current_journey
  def initialize
    @journey_history = []
    @current_journey = nil
  end
  def start(station)
    get_current_journey
    @current_journey.entry_station = station.name
    @journey_history << @current_journey
    true
  end
  def get_current_journey
    @current_journey ||= Journey.new
  end
end
