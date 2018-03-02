require_relative './lib/oystercard'
require_relative './lib/station'
require_relative './lib/journey'
require_relative './lib/journey_log'

oc = OysterCard.new
s1 = Station.new(1,1)
s2 = Station.new(2,2)
s3 = Station.new(3,3)
s4 = Station.new(4,4)
s5 = Station.new(5,5)

oc.top_up(10)

puts 'touch in s1'
p oc.touch_in(s1)
puts 'touch out s2'
p oc.touch_out(s2)
puts "balance: #{oc.balance} \n"

puts 'touch in s3'
p oc.touch_in(s3)
puts "no touch out"
puts "balance: #{oc.balance} \n"

puts 'touch in s4'
p oc.touch_in(s4)
puts "balance: #{oc.balance} \n"

puts 'touch out s5'
p oc.touch_out(s5)
puts "balance: #{oc.balance} \n"
p ''
p oc
