class OysterCard
  attr_accessor :balance
  DEFAULT_BAL = 0

  def initialize(balance = DEFAULT_BAL)
    @balance = balance
  end

  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > 90
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

end
