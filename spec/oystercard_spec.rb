require 'oystercard'

describe OysterCard do
  subject(:oystercard) { OysterCard.new(0) } # Default balance = 0
   # Creating a new OysterCard above bal = 0

  it 'should have default balance of 0' do
    expect(oystercard.balance).to eq(0)
  end
end
