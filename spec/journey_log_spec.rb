require 'journey_log'

describe JourneyLog do

  let(:journey_comp) { double :journey_comp }
  let(:journey_incomp) { double :journey_incomp }
  let(:stn1) { double :stn1, name: :Station1, zone: 1 }
  let(:stn2) { double :stn2, name: :Station2, zone: 2 }

  subject(:jlog_comp) { described_class.new }
  subject(:jlog_incomp) { described_class.new }

  describe 'knows when journeys are started, finished and their completion status' do

    context 'for legitimate journeys' do

      before do
        jlog_comp.start(stn1)
      end

      it 'should tell us if the journey is initiated' do
        expect(jlog_comp.in_journey).to be_truthy
      end

      it 'should log the entry station' do
        expect(jlog_comp.entry_station).to eq stn1
      end

      it 'should tell us if the journey is completed' do
        jlog_comp.finish(stn2)
        expect(jlog_comp.in_journey).to be_falsey
      end

      it 'should log the exit station' do
        jlog_comp.finish(stn2)
        expect(jlog_comp.history.last[:exit]).to eq stn2
      end

      it 'should log a single journey' do
        jlog_comp.finish(stn2)
        expect(jlog_comp.history).to eq [{entry: stn1, exit: stn2, fare: 2}]
      end

      it 'should log multiple journeys' do
        jlog_comp.finish(stn2)
        jlog_comp.start(stn2)
        jlog_comp.finish(stn1)
        expect(jlog_comp.history).to eq [{entry: stn1, exit: stn2, fare: 2}, {entry: stn2, exit: stn1, fare: 2}]
      end
    end

    context 'for illegal journeys' do

      before do
        jlog_incomp.start(stn1)
      end

      it 'should tell us if the journey is incomplete (no touch out)' do
        expect(jlog_incomp.in_journey).to be_truthy
      end

    end

  end

end
