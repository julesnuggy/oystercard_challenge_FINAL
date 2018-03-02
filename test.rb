require_relative './lib/oystercard'
require_relative './lib/journey_log'
require_relative './lib/journey'
require_relative './lib/station'

oc = Oystercard.new
s1 = Station.new(1,1)
s2 = Station.new(2,2)
s3 = Station.new(3,3)
s4 = Station.new(4,4)
s5 = Station.new(5,5)

oc.top_up(10)

puts 'Touch in s1, touch out s1. Complete same-zone journey'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s1)
oc.touch_out(s1)
p "Post-journey balance: £#{oc.balance}"
puts ""

puts 'Touch in s1, touch out s2. Complete journey with 1 zone cross-over'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s1)
oc.touch_out(s2)
p "Post-journey balance: £#{oc.balance}"
puts ""

puts 'Touch in s3, no touch out. Incomplete journey.'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s3)
p "Post-journey balance: £#{oc.balance}"
puts ""

puts 'Touch in s5, touch out s1. Complete journey with 4 zone cross-over. Get charged penalty for previous incomplete journey.'
p "Pre-journey balance: £#{oc.balance}"
oc.touch_in(s5)
oc.touch_out(s1)
p "Post-journey balance: £#{oc.balance}"
puts ""

puts "Show history:"
p oc.show_history

p "Pre-journey balance: £#{oc.balance}"
puts 'Touch in s2 - will result in an error due to insufficient balance.'
oc.touch_in(s2)
puts ""
