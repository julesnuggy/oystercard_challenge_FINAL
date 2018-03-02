require 'journey'

describe Journey do
  subject(:journey) { described_class.new(waterloo) }
  let(:waterloo) { double :waterloo, name: :Waterloo, zone: 1 }
  let(:paddington) { double :paddington, name: :Paddington, zone: 1 }

  before do
    journey
  end

  describe '#start' do

    it 'should set entry_station to waterloo' do
      expect(journey.entry_station).to eq waterloo
    end

    it 'should set @completed to return false' do
      expect(journey.completed).to eq false
    end

  end

  describe '#stop' do

    it 'should set exit station to paddington' do
      journey.finish_journey(paddington)
      expect(journey.exit_station).to eq paddington
    end

    it 'should set @completed to return true' do
      journey.finish_journey(paddington)
      expect(journey.completed).to eq true
    end
  end

  describe '#calc_fare' do

    it 'should return the minimum fare when journey completed' do
      journey.finish_journey(paddington)
      expect(journey.calc_fare).to eq described_class::MIN_FARE
    end

    it 'should return the penalty fare when journey not completed' do
      expect(journey.calc_fare).to eq described_class::PENALTY
    end
  end

end
