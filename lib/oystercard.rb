class OysterCard
  attr_reader :completed_journeys, :balance

  MIN_BAL, MAX_BAL = 0, 90

  def initialize(journey_log_class = JourneyLog)
    @journey_log = journey_log_class.new()
    @balance = MIN_BAL
  end

  def top_up(amount)
    raise "Balance cannot be more than #{MAX_BAL}" if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient balance' if @balance < Journey::MIN_FARE
    deduct(@journey_log.calc_penalty) if @journey_log.in_journey
    @journey_log.start(station)
  end

  def touch_out(station)
    fare = @journey_log.stop(station)
    deduct(fare)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
