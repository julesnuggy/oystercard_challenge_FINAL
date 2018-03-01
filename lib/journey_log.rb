require_relative 'journey'
class JourneyLog
attr_reader :entry_station, :exit_station,

  def initialize
  # @journey_class = Journey
  @journey = Journey.new
  @mid_journey = false
  @history = []
  end

# start journey methods
  def start(station = nil)
    # fare = PENALTY if @journey.complete == false




    @mid_journey = true
    @entry_station = station
    @journey = @journey_class.new(@entry_station)
  end

  def stop(station = nil)
    @exit_station = station
    @journey.finish_journey(@exit_station)
    log_journey
    # reset all journey related stuff to default as it's completed and stored
    reset_journey
    # return @this_journey
  end

    def log_journey
      @this_journey = { from: @entry_station, to: @exit_station, fare: @journey.correct_fare }
    end


    def reset_journey
      @mid_journey = false
      @entry_station = @exit_station = nil
    end

  def in_journey?
    @mid_journey
  end




end
