WhereCampPDX Arrivals Board
===========================

This is an application that simulates an airport arrivals board. It is used to play an amusing little party ice-breaker game involving flight numbers.

Requirements
------------
the *google-geocode* gem

ToDo
----

 1. Ticket#disance to calculate the great circle distance between origin and destination.
 2. Ticket#velocity to calculate a velocity (or some kind of score) based on distance and time.
 3. Ticket#transport to place a ticket in a bucket based on velocity.
 4. Make Ticket#set_locations return something useful in the case of geocoding errors.
 5. Make ArrivalsBoard#arrival set the tickets locations