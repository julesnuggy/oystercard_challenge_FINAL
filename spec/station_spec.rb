require 'station'

describe Station do
  subject(:station) { Station.new("Waterloo", 1) }

  it 'knows its name' do
    expect(station.name).to eq("Waterloo")
end

  it 'knows its zone' do
    expect(station.zone).to eq(1)
  end
end
