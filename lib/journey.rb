# Journey class definiation
# This takes care of all journey related things and should return journey info
# when referred to
class Journey
  attr_reader :correct_fare, :this_journey

  MIN_FARE, PENALTY = 1, 6

  def initialize(entry_station = nil)
    # @entry_station = entry_station
    # @exit_station = nil
  end

def start_journey
  if completed?
    deduct(PENALTY)
    @completed_journeys << @journey.stop.merge(fare: PENALTY)
  end


  @entry_station = entry_station
  @exit_station = nil
end

def finish_journey(station)
  @exit_station = station
  fare
end

def process_penalty

end
  private
  def fare
    @correct_fare = completed? ? MIN_FARE : PENALTY
  end

  def completed?
    !(@entry_station.nil? || @exit_station.nil?)
  end



end
