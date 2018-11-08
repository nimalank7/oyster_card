class JourneyLog
  attr_reader :journey_history, :current_journey
  def initialize
    @journey_history = []
    @current_journey = nil
  end
end
