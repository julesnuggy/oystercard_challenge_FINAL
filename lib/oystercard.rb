class OysterCard
  attr_accessor :balance, :card_status
  DEFAULT_BAL = 0
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BAL)
    @balance = balance
    @card_status = false
  end

  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > 90
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    raise 'Insufficient balance' if @balance < MIN_FARE
    @card_status = true
  end

  def touch_out
    @card_status = false
  end

  def in_journey?
    @card_status
  end
end
