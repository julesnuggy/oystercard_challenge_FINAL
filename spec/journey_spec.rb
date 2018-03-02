require 'journey'

describe Journey do
  subject(:journey) { described_class.new(stn1) }
  let(:stn1) { double :stn1, name: :Station1, zone: 1 }
  let(:stn2) { double :stn2, name: :Station2, zone: 2 }
  let(:stn3) { double :stn3, name: :Station3, zone: 3 }
  let(:stn4) { double :stn4, name: :Station4, zone: 4 }

  before do
    journey
  end

  describe '#start' do

    it 'should set entry_station to Station1' do
      expect(journey.entry_station).to eq stn1
    end

  end

  describe '#stop' do

    it 'should set exit station to Station1' do
      journey.finish_journey(stn1)
      expect(journey.exit_station).to eq stn1
    end

  end

  describe '#calc_fare' do

    it 'should charge the minimum fare when a single-zone journey is completed' do
      journey.finish_journey(stn1)
      expect(journey.calc_fare).to eq described_class::MIN_FARE
    end

    it 'should charge the £2 when 1 zone boundary is crossed' do
      journey.finish_journey(stn2)
      expect(journey.calc_fare).to eq 2
    end

    it 'should charge the £3 when 2 zone boundaries are crossed' do
      journey.finish_journey(stn3)
      expect(journey.calc_fare).to eq 3
    end

    it 'should charge the £3 when 3 zone boundaries are crossed' do
      journey.finish_journey(stn4)
      expect(journey.calc_fare).to eq 4
    end

    it 'should charge the penalty fare when journey not completed' do
      expect(journey.calc_fare).to eq described_class::PENALTY
    end

  end

end
