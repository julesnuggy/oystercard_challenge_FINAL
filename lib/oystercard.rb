class Oystercard
  attr_reader :balance

  MIN_BAL, MIN_FARE, MAX_BAL = 0, 1, 90

  def initialize(journey_log_class = JourneyLog)
    @journey_log = journey_log_class.new()
    @balance = MIN_BAL
  end

  def top_up(amount)
    raise "Your balance cannot be more than £#{MAX_BAL}" if (@balance + amount) > MAX_BAL
    @balance += amount
  end

  def touch_in(station)
    if @journey_log.in_journey
      deduct(@journey_log.calc_penalty)
    end
    raise "Not enough credit in balance" if @balance < MIN_FARE
    @journey_log.start(station)
  end

  def touch_out(station)
    fare = @journey_log.finish(station)
    deduct(fare)
  end

  def show_history
    puts @journey_log.history
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
