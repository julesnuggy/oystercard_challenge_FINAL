require 'station'

describe Station do
subject(:station) { Station.new("Canning Town", 2) }

it 'knows its name' do
   expect(station.name).to eq("Canning Town")
 end

 it 'knows its zone' do
   expect(station.zone).to eq(2)
 end
end
