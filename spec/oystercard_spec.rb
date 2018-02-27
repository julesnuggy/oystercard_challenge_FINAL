require 'oystercard'

describe OysterCard do
  MAX_BALANCE = 90
  MIN_FARE = 1
  subject(:oystercard) { OysterCard.new(0) } # Default balance = 0
   # Creating a new OysterCard above bal = 0
   before(:each) do
     @barking = double(:barking, name: 'Barking')
     @aldgate = double(:aldgate, name: 'Aldgate')
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

    it 'should deduct correct fare amount (using MIN_FARE for test)' do
      oystercard.topup(MAX_BALANCE)
      oystercard.touch_in(@barking)
      expect { oystercard.touch_out(@aldgate) }.to change{ oystercard.balance }.by(-MIN_FARE)
    end

  end

# # touch_in, touch_out and in_journey?
  describe '#touch_in' do
    it 'shoud respond to touch_in' do
      expect(oystercard).to respond_to(:touch_in)
    end
    it 'should set mid_journey to true' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      expect(oystercard.mid_journey).to eq(true)
    end

    it 'should raise error if balance is less than min fare(1)' do
      expect { oystercard.touch_in(@barking) }.to raise_error 'Insufficient balance'
    end
    it 'should set @entry_station to @barking' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      expect(oystercard.entry_station).to eq(@barking)
    end

  end

  describe '#touch_out' do
    it 'shoud respond to touch_out' do
      expect(oystercard).to respond_to(:touch_out).with(1).arguments
    end
    it 'should set mid_journey to false' do
      oystercard.touch_out(@aldgate)
      expect(oystercard.mid_journey).to eq(false)
    end

    it 'should set @entry_station to nil' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      oystercard.touch_out(@aldgate)
      expect(oystercard.entry_station).to eq(nil)
    end

    it 'journey_history should be empty in the start' do
      expect(oystercard.journey_history).to eq([])
    end

    it 'should push history hash to journey_history' do
      oystercard.topup(MIN_FARE)
      oystercard.touch_in(@barking)
      oystercard.touch_out(@aldgate)
      expect(oystercard.journey_history).to eq([{from: @barking, to: @aldgate}])
    end

  end

  describe '#in_journey?' do
    it 'shoud respond to in_journey?' do
      expect(oystercard).to respond_to(:in_journey?)
    end
    it 'should return mid_journey' do
      expect(oystercard.in_journey?).to eq(oystercard.mid_journey)
    end
  end
end
