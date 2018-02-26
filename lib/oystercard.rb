class OysterCard
  attr_accessor :balance
  DEFAULT_BAL = 0

  def initialize(balance = DEFAULT_BAL)
    @balance = balance
  end
end
