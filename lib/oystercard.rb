# require 'date'

class OysterCard
  attr_accessor :card_status, :balance, :journey_history

  DEFAULT_BAL = 0
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BAL)
    @balance = balance
    @card_status = false
    @journey_history = []
  end

  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > 90
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance' if @balance < MIN_FARE
    @card_status = true
    @journey_history << {from: station.name}
  end

  def touch_out
    deduct(MIN_FARE)
    @card_status = false
  end

  def in_journey?
    @card_status
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
