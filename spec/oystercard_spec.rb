require 'oystercard'

describe OysterCard do
  MAX_BALANCE, MIN_FARE, PENALTY = 90, 1, 6
  subject(:oystercard) { OysterCard.new(0) } # Default balance = 0
   # Creating a new OysterCard above bal = 0
  before(:each) do
    @barking = double(:barking, name: 'Barking', zone: 4)
    @aldgate = double(:aldgate, name: 'Aldgate', zone: 1)
  end

  it 'should have default balance of 0' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#topup' do
    it 'OysterCard should respond to topup with amount as argument' do
      expect(oystercard).to respond_to(:topup).with(1).arguments #this tells how many arguments to expect
    end

    it 'should add topup amount to balance' do
      expect(oystercard.topup(10)). to eq(10)
    end

    it 'Should raise_error when try balance > 90' do
      expect { oystercard.topup(MAX_BALANCE + 1) }.to raise_error 'Balance cannot be more than £90'
    end
  end

  describe '#deduct proxy tested using touch_in and touch_out' do
    # it 'OysterCard should respond to deduct with amount as argument' do
    #   expect(oystercard).to respond_to(:deduct).with(1).arguments #this tells how many arguments to expect
    # end

    it 'should deduct fare from balance' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      oystercard.touch_out(@aldgate)
      expect(oystercard.balance).to eq(0)
    end

    it 'should deduct correct fare (MIN_FARE) amount when touched in & touched out' do
      oystercard.topup(MAX_BALANCE)
      oystercard.touch_in(@barking)
      expect { oystercard.touch_out(@aldgate) }.to change{ oystercard.balance }.by(-MIN_FARE)
    end

    it 'should deduct PENALTY fare when not touched in before touched out ' do
      oystercard.topup(MAX_BALANCE)
      expect { oystercard.touch_out(@aldgate) }.to change{ oystercard.balance }.by(-PENALTY)
    end

  end

# # touch_in, touch_out and in_journey?
  describe '#touch_in' do
    it 'shoud respond to touch_in' do
      expect(oystercard).to respond_to(:touch_in)
    end

    it 'should raise error if balance is less than min fare(1)' do
      expect { oystercard.touch_in(@barking) }.to raise_error 'Insufficient balance'
    end

  end

  describe '#touch_out' do
    it 'shoud respond to touch_out' do
      expect(oystercard).to respond_to(:touch_out).with(1).arguments
    end

    it 'completed_journeys should be empty in the start' do
      expect(oystercard.completed_journeys).to eq([])
    end

    it 'should push history hash to completed_journeys' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      oystercard.touch_out(@aldgate)
      expect(oystercard.completed_journeys).to eq([{ from: @barking, to: @aldgate , fare: MIN_FARE}])
    end

  end

########## tests redundant as methods turned private

  # describe '#in_journey?' do
  #   it 'shoud respond to in_journey?' do
  #     expect(oystercard).to respond_to(:in_journey?)
  #   end
  #   it 'should return mid_journey' do
  #     expect(oystercard.in_journey?).to eq(oystercard.mid_journey)
  #   end
  # end

  # describe '#fare' do
  #   it 'Should respond to fare' do
  #     expect(oystercard).to respond_to(:fare)
  #   end
  # end
end
