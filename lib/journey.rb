# Journey class definiation
# This takes care of all journey related things and should return journey info
# when referred to
class Journey
  attr_reader :fare, :entry_station, :exit_station

  MIN_FARE, PENALTY = 1, 6

  def initialize(station = nil)
    @entry_station = station
  end

  def finish_journey(station = nil)
    @exit_station = station
    calc_fare
  end

  def calc_fare
    @fare = completed? ? MIN_FARE + (@entry_station.zone - @exit_station.zone).abs : PENALTY
  end

private

  def completed?
    !(@entry_station.nil? || @exit_station.nil?)
  end

end
