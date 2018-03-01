# Journey class definiation
# This takes care of all journey related things and should return journey info
# when referred to
class Journey
  attr_reader :correct_fare, :completed

  MIN_FARE, PENALTY = 1, 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @completed = false
  end

  def finish_journey(station)
    @exit_station = station
    @completed = true
    fare
  end

  private

  def fare
    @correct_fare = completed? ? MIN_FARE : PENALTY
  end

  def completed?
    @completed
  end

end
