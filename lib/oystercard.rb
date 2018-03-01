class OysterCard
  attr_reader :completed_journeys, :balance

  MAX_BAL = 90

  def initialize(journey_log_class = JourneyLog)
    @journey_log = journey_log_class.new()
    @balance = 0
  end

  # topup method tops up the oystercard with amount given
  # (throws error if amount + current balance goes above MAX_BAL)
  def topup(amount)
    raise 'Balance cannot be more than £90' if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  # touch_in method take station object in and starts a journey
  # throws error if balance is less than Journey::MIN_BAL (£1)
  def touch_in(station)
    # Check if balance is sufficient
    raise 'Insufficient balance' if @balance < Journey::MIN_FARE
    # Initiate the Journey Log #start method (creates a new Journey object)
    @journey_log.start(station)
    # Deduct the penalty fare if applicable
    deduct(@journey_log.penalty_amt)
  end

  # touch_out takes station object as an argument
  def touch_out(station)
    # correct_fare is out put by the Journey Log #stop method
    correct_fare = @journey_log.stop(station)
    deduct(correct_fare)
  end

  private

  def deduct(correct_fare)
    @balance -= correct_fare
  end

end
