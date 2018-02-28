require 'journey'

describe Journey do
  subject(:journey) { Journey.new() }
  let(:oystercard) { double :oystercard, topup: nil, touch_in: nil }
  let(:barking) { double :barking, name: 'Barking', zone: 4 }
  let(:aldgate) { double :aldgate, name: 'Aldgate', zone: 1 }

  describe '#start' do

    it 'should set in_journey? to return true' do
      journey.start('barking')
      expect(journey.in_journey?).to eq(true)
    end

    it 'should set entry_station to barking' do
      #   # oystercard.topup(MIN_FARE)
      journey.start(barking)
      expect(journey.entry_station).to eq(barking)
    end
  end

  describe '#stop' do
    it 'should set in_journey? to return false' do
      journey.stop(aldgate)
      expect(journey.in_journey?).to eq(false)
    end

    it 'should return a journey log for one journey' do
      journey.start(barking)
      expect(journey.stop(aldgate)).to eq({ from: barking, to: aldgate })
    end

    it 'should set entry_station to nil' do
      journey.start(barking)
      journey.stop(aldgate)
      expect(journey.entry_station).to eq(nil)
    end
  end
end
