require 'oystercard'

describe OysterCard do
  MAX_BALANCE = 90
  subject(:oystercard) { OysterCard.new(0) } # Default balance = 0
   # Creating a new OysterCard above bal = 0

  it 'should have default balance of 0' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#topup' do
    it 'OysterCard should respond to topup' do
      expect(oystercard).to respond_to(:topup).with(1).arguments #this tells how many arguments to expect
    end

    it 'should add topup amount to balance' do
      expect(oystercard.topup(10)). to eq(10)
    end

    it 'Should raise_error when try balance > 90' do
    expect{ oystercard.topup(MAX_BALANCE+1) }.to raise_error 'Balance cannot be more than £90'
    end
  end
end
