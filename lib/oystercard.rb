# require 'date'
# require './lib/station'

class OysterCard
  attr_accessor :mid_journey, :balance
  attr_reader :entry_station, :exit_station, :journey_history

  DEFAULT_BAL = 0
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BAL)
    @balance = balance
    @mid_journey = false
    @entry_station = nil
    @journey_history = []
  end

  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > 90
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance' if @balance < MIN_FARE
    @mid_journey = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @journey_history << {from: @entry_station, to: @exit_station}
    @mid_journey = false
    @entry_station = nil
    @entry_station = nil
  end

  def in_journey?
    @mid_journey
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
