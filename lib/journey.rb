class Journey
  attr_accessor :entry_station, :exit_station # Consider putting this into methods
  attr_accessor :entry_station_zone, :exit_station_zone # Consider putting these into methods
  def initialize
    @entry_station = ""
    @entry_station_zone = 0
    @exit_station = ""
    @exit_station_zone = 0
  end
end
