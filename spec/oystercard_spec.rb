require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new(jlog_cls_comp) }
  subject(:oystercard_min) { described_class.new(jlog_cls_comp) }
  subject(:oystercard_empty) { described_class.new(jlog_cls_comp) }
  subject(:oystercard_incomp) { described_class.new(jlog_cls_incomp) }

  let(:jlog_cls_comp) { double :jlog_cls_comp, new: jlog_comp }
  let(:jlog_comp) { double :jlog_comp, in_journey: false }
  let(:journey_comp) { double :journey, fare: 1, completed: true }

  let(:jlog_cls_incomp) { double :jlog_cls_comp, new: jlog_incomp }
  let(:jlog_incomp) { double :jlog_comp, in_journey: true }
  let(:journey_incomp) { double :journey, fare: 6, completed: false }

  let(:waterloo) { double(:waterloo, name: :Waterloo, zone: 1) }
  let(:paddington) { double(:paddington, name: :Paddington, zone: 1) }

  before do
    oystercard.top_up(10)
    oystercard_incomp.top_up(10)
    oystercard_min.top_up(1)
    allow(jlog_comp).to receive(:start)
    allow(jlog_comp).to receive(:finish) { 1 } #Return MIN_FARE for complete journey
  end

  describe "check balance and enforce limits" do

    it 'should have a balance of 0 when initialized' do
      expect(oystercard_empty.balance).to eq 0
    end

    it 'should respond to #top_up by adding money to the balance' do
      expect { oystercard.top_up(10) }.to change {oystercard.balance}.by(10)
    end

    it 'should raise an error when #top_up will cause balance to exceed the limit' do
      expect { oystercard.top_up(100) }.to raise_error("Your balance cannot be more than £#{Oystercard::MAX_BAL}")
    end

    it 'should raise an error when you try to #touch_in with less than the minimum fare on balance' do
      expect { oystercard_empty.touch_in(waterloo) }.to raise_error("Not enough credit in balance")
    end

    it 'should NOT raise an error when balance equals minimum fare' do
      expect { oystercard_min.touch_in(waterloo) }.not_to raise_error()
    end

  describe 'amends balances appropiately when touching in/out'

    it 'should charge the minimum fare when #touch_out of a complete journey' do
      expect { oystercard.touch_out(waterloo) }.to change { oystercard.balance }.by(-journey_comp.fare)
    end

    it 'should charge the penalty fare when #touch_in for incomplete journeys' do
      allow(jlog_incomp).to receive(:start)
      allow(jlog_incomp).to receive(:calc_penalty) { 6 }
      expect { oystercard_incomp.touch_in(waterloo) }.to change {oystercard_incomp.balance}.by(-journey_incomp.fare)
    end

  end

end
