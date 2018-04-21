# OYSTERCARD CHALLENGE
## Makers Academy (Week 2)

### Foreword

This is the final repo for the Oystercard Challenge. Previous repos for this same challenge were also created but this is the final working version:
* https://github.com/julesnuggy/Oystercard-challenge
* https://github.com/julesnuggy/oystercard_challenge_2

### Descriptions
This is a program which simulates the Oystercard system to a very basic level. There are 4 classes of objects: Oystercard, JourneyLog, Journey and Station. The first 3 are very closely linked to each other while Station is more removed, though still necessary for the program to run.

**Station**
* Create a new `Station` object using the command `Station.new(name, zone)`
* The name is for informational purposes.
* The zone will determine the fare between two given stations.

**Oystercard**
This is the only class the user can directly interact with. The user can create an `Oystercard` and travel between `Stations`.

* Create a new `Oystercard` object using the command `Oystercard.new`
* It will automatically initiate a new `JourneyLog` object, which will keep track of all `Journey`s the for its associated Oystercard.
* Add money to the Oystercard using the `#top_up(amount)` method, with an integer for the desired amount to top up.
* `#touch_in(station)` to begin your journey, with the argument being a `Station` object.
* `#touch_out(station)` to finish your journey, with the argument being a `Station` object.
* `#show_history` will show the entire journey history made on the `Oystercard`

**JourneyLog**
A delegated class from the `Oystercard` class, this essentially acts as the "database" for the card. Whenever the `Oystercard` touches-in, a new `Journey` object will be initiated.

* `@in_journey` is an attribute telling us if the card is currently in-journey or not. Primarily used to determine if a penalty fare should be applied.
* `@history` is an array which stores the card's journey history.
* `@curr_journey` is a hash which records the current journey's `@entry_station`, `@exit_station` and `@fare` attribute details.
* `#calc_penalty` is called every time the `Oystercard` touches in to determine if the penalty fare should be charged. If a penalty applies, then the previous journey was incomplete, so it will be added to `@history` at this point.
* `#start` initiates the journey for the current session (when `#touch_in` is called).
* `finish` ends the journey for the current session (when `#touch_out` is called). It will calculate and return the correct fare to `Oystercard`, log the just-completed journey in `@history` and reset the `@entry_station` and `@exit_station` attributes.
* `#log_journey` pushes a duplicate of the `@curr_journey` hash to the `@history` array. A duplicate is required due to the hash's use of attributes to fill the values.
* `#reset_journey` resets the journey attributes to allow a clean start for the next journey.

**Journey**
`Journey` is a delegated class from `JourneyLog`, which is solely responsible for calculating the correct fare for the current journey.

* `@entry_station` is assigned at initialisation, when `JourneyLog` creates the `Journey` object.
* `#finish_journey` assigns `@exit_station` and calculates the appropriate fare for the journey.
* `#calc_fare` uses the `#complete?` method to determine if `@fare` should be the penalty fare (for incomplete journeys) or the correct fare between two station zones (for completed journeys). The correct fare is calculated as the minimum fare (MIN_FARE = £1) plus an extra £1 for the number of zone-borders crossed.
e.g. if the user travels from zone 1 to zone 4, they will be charged £1 + £(4-1) = £4
* `completed?` is a boolean query method which determines if a journey is complete or not based on `@entry_station` and `@exit_station` attributes being `nil` or not.

### Example
(This is the same as the test.rb file)

```Ruby
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
```
