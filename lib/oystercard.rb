# require 'date'
# require './lib/station'

class OysterCard
  attr_reader :entry_station, :exit_station, :journey_history, :mid_journey, :balance

  # default constants (defined in one line)
  MIN_BAL, MAX_BAL, MIN_FARE, PENALTY = 0, 90, 1, 6

  # MIN_BAL = 0
  # MAX_BAL = 90
  # MIN_FARE = 1
  # PENALTY = 6

  def initialize(balance = MIN_BAL)
    @balance = balance
    @mid_journey = false
    @entry_station = @exit_station = nil
    @journey_history = []
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
    raise 'Insufficient balance' if @balance < MIN_FARE
    @mid_journey = true
    @entry_station = station
  end

  # touch_out takes station object as an argument and saves current journey to
  # journey_history. Also resets current journey status
  def touch_out(station)
    deduct(fare)
    @exit_station = station
    @journey_history << { from: @entry_station, to: @exit_station }
    # reset all journey related stuff to default as it's completed and stored
    @mid_journey = false
    @entry_station = @exit_station = nil
  end

  private

  def in_journey?
    @mid_journey
  end

  def fare
    in_journey? ? MIN_FARE : PENALTY
  end

  def deduct(correct_fare)
    @balance -= correct_fare
  end

end
