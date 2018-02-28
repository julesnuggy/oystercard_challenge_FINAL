# require 'date'
# require './lib/station'
require_relative 'journey'

class OysterCard
  attr_reader :completed_journeys, :balance
  # attr_reader  :entry_station, :exit_station, :mid_journey,

  # default constants (defined in one line)
  MIN_BAL, MAX_BAL, MIN_FARE, PENALTY = 0, 90, 1, 6

  def initialize(balance = MIN_BAL)
    @balance = balance
    # @mid_journey = false
    # @entry_station = @exit_station = nil
    @completed_journeys = []
    @journey = Journey.new
  end

  # topup method tops up the oystercard with amount given
  # (throws error if amount + current balance goes above MAX_BAL)
  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  # touch_in method take station object in and starts a journey
  # throws error if balance is less than MIN_FARE
  def touch_in(station)
    # When user forgets to touch out, charge them penalty fare
    if @journey.in_journey?
      deduct(PENALTY)
      @completed_journeys << @journey.stop.merge(fare: PENALTY)
    end

    raise 'Insufficient balance' if @balance < MIN_FARE
    @journey.start(station)
  end

  # touch_out takes station object as an argument and saves current journey to
  # completed_journeys. Also resets current journey status
  def touch_out(station)
    deduct(fare())
    correct_fare = fare
    # @exit_station = station
    @completed_journeys << @journey.stop(station).merge(fare: correct_fare)
    # reset all journey related stuff to default as it's completed and stored
    # @mid_journey = false
    # @entry_station = @exit_station = nil
  end

  private
  #
  # def in_journey?
  #   @mid_journey
  # end

  def fare
    @journey.in_journey? ? MIN_FARE : PENALTY
  end

  def deduct(correct_fare)
    @balance -= correct_fare
  end

end
