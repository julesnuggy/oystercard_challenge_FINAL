require_relative 'journey'

class JourneyLog
  attr_reader :entry_station, :exit_station, :in_journey, :fare

  def initialize
    @journey_class = Journey
    @in_journey = false # Tells you if you're on a journey
    @history = [] # Array to store entire travel history
    @curr_journey = {}
    @fare = 0
  end

  def calc_penalty
    @fare = @journey.calc_ fare
    log_journey
    @fare
  end

  def start(station = nil)
    @journey = @journey_class.new(station)
    @entry_station = station
    @in_journey = true
  end

  def stop(station = nil)
    @exit_station = station
    @fare = @journey.finish_journey(@exit_station)
    log_journey
    reset_journey
    @fare

  end

private

  def log_journey
    @curr_journey = {entry: @entry_station, exit: @exit_station, fare: @fare}
    @history << @curr_journey.dup
  end

  def reset_journey
    @in_journey = false
    @entry_station = @exit_station = nil
  end

  def in_journey?
    @in_journey
  end

end
