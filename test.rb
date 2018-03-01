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

oc.topup(10)

p 'touch in s1'
 oc.touch_in(s1)
p 'touch out s2'
 oc.touch_out(s2)
p "balance: #{oc.balance}"
p ''
p 'touch in s3'
 oc.touch_in(s3)
p 'no touch out'

p 'touch in s4 (no touch out from before)'
 oc.touch_in(s4)
p "balance: #{oc.balance}"
p ''
p 'touch out s5'
 oc.touch_out(s5)
p "balance: #{oc.balance}"
p ''
p oc
