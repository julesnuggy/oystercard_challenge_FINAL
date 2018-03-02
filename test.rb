require_relative './lib/oystercard'
require_relative './lib/station'
require_relative './lib/journey'
require_relative './lib/journey_log'

oc = Oystercard.new
s1 = Station.new(1,1)
s2 = Station.new(2,2)
s3 = Station.new(3,3)
s4 = Station.new(4,4)
s5 = Station.new(5,5)

oc.top_up(10)

puts 'touch in s1, touch out s1'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s1)
oc.touch_out(s1)
p "Post-journey balance: £#{oc.balance}"
puts ""

puts 'touch in s1, touch out s2'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s1)
oc.touch_out(s2)
p "Post-journey balance: £#{oc.balance}"
puts ""

p "Pre-journey balance: £#{oc.balance}"
puts 'touch in s3, no touch out'
oc.touch_in(s3)
p "Post-journey balance: £#{oc.balance}"
puts ""

p "Pre-journey balance: £#{oc.balance}"
puts 'touch in s5, touch out s1'
oc.touch_in(s5)
oc.touch_out(s1)
p "Post-journey balance: £#{oc.balance}"
puts ""

p oc.show_history

p "Pre-journey balance: £#{oc.balance}"
puts 'touch in s2'
oc.touch_in(s2)
puts ""
