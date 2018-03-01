#require_relative 'journey'
class OysterCard
  attr_reader :completed_journeys, :balance

  # default constants (defined in one line)
  MIN_BAL, MAX_BAL = 0, 90

  def initialize(balance = MIN_BAL, journey_log_class = JourneyLog)
    @journey_log = journey_log_class.new()
    @balance = balance
    @completed_journeys = []
    #@journey = journey
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
    # HARDCODED, NEED TO FIX
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
    deduct(@journey.correct_fare)
    # correct_fare = fare
    # @exit_station = station
    # @completed_journeys << @journey.stop(station).merge(fare: correct_fare)

    # journey_log.add_log(@journey.stop(station).merge(fare: @journey.correct_fare))

  end

  private
  # def fare
  #   @journey.in_journey? ? MIN_FARE : PENALTY
  # end

  def deduct(correct_fare)
    @balance -= correct_fare
  end

end
