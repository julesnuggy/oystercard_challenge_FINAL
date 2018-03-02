# Journey class definiation
# This takes care of all journey related things and should return journey info
# when referred to
class Journey
  attr_reader :fare, :completed

  MIN_FARE, PENALTY = 1, 6

  def initialize(station = nil)
    @entry_station = station
    @completed = false
  end

  def finish_journey(station = nil)
    @exit_station = station
    @completed = true
    calc_fare
  end

  def calc_fare
    @fare = completed? ? MIN_FARE : PENALTY
  end

private

  def completed?
    @completed
  end

end
