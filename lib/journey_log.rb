require_relative 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station, :penalty_amt

  def initialize
    @journey_class = Journey
    @mid_journey = false # Tells you if you're on a journey
    @history = [] # Array to store entire travel history
    @curr_journey = {} # Hash to store current journey details
    @penalty_amt = 0
  end

  def start(station = nil)
    # Check if we need to charge a penalty
    if in_journey?
      p 'Charged penalty fare for incomplete journey.'
      @history << @curr_journey.dup
      @penalty_amt = Journey::PENALTY
      @mid_journey = false
      @history.last[:fare] = @penalty_amt #Update entry for prev incomplete journey
    else
      @penalty_amt = 0
    end

    # Start real journey
    @mid_journey = true
    @entry_station = station
    @journey = @journey_class.new(@entry_station)
    @curr_journey[:entry] = station
  end

  def stop(station = nil)
    @exit_station = station
    @curr_journey[:exit] = station
    @journey.finish_journey(@exit_station)
    @curr_journey[:fare] = @journey.correct_fare
    @history << @curr_journey.dup
    reset_journey
    @curr_journey[:fare]
  end

private

  def reset_journey
    @mid_journey = false
    @entry_station = @exit_station = nil
    @curr_journey[:entry] = nil
    @curr_journey[:exit] = nil
  end

  def in_journey?
    @mid_journey
  end

end
