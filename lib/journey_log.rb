require_relative "./journey.rb"
require_relative "./station.rb"


class JourneyLog
  def initialize
    @journey_history = []
    @current_journey = nil
  end

  def start(station)
    get_current_journey
    set_entry_station(station)
    set_entry_station_zone(station)
    log_journey
    true
  end

  def finish(station)
    if @current_journey == nil
      get_current_journey
      set_exit_station(station)
      set_exit_station_zone(station)
      log_journey
      @current_journey = nil
      return true
    end
    get_current_journey
    set_exit_station(station)
    set_exit_station_zone(station)
    @current_journey = nil
    true
  end
  def show_all_journeys
    @journey_history.clone
  end
  private

  def log_journey
    @journey_history << @current_journey
  end

  def set_exit_station(station)
    @current_journey.exit_station = station.name
  end

  def set_entry_station(station)
    @current_journey.entry_station = station.name
  end

  def set_exit_station_zone(station)
    @current_journey.exit_station_zone = station.zone
  end

  def set_entry_station_zone(station)
    @current_journey.entry_station_zone = station.zone
  end

  def get_current_journey
    @current_journey ||= Journey.new
  end
end
