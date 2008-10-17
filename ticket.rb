require 'rubygems'
require 'google_geocode'    # this is the google-geocode gem


# represents a trip, performs calculations  
# each ticket object represents a pair of physical tickets 
class Ticket
  
  # a list of available transports
  # we need to determine how to break
  # these up based on velocity.
  #
  # listed slowest to fastest
  Transports = [
    'Tortoise Caravan',
     'Palaquin',
     'Elephant',
     'Bicycle Rickshaw',
     'Covered Wagon',
     'Zeppelin',
     'Omnibus',
     'Steam Locomotive',
     'Shinkansen',
     'Concorde',
     'Ballistic Rocket Plane'
  ]
  
  attr_accessor :number                 # the ticket number
  attr_accessor :first_departure_time   # the time the first ticket is given out
  attr_accessor :second_departure_time  # the time the second ticket is given out
  attr_accessor :arrival_time           # the time the pair of people come back
  attr_accessor :origin                 # person #1's hometown
  attr_accessor :destination            # person #2's hometown
  
  def initialize(number)
    @number = number
  end
  
  # when called the first time, sets first departure time
  # subsequent times set second departure time
  #
  # yes, this is sloppy and oddly state-dependant
  #
  def depart
    if @first_departure_time.nil?
      @first_departure_time = Time.now
    else
      @second_departure_time = Time.now
    end
  end
  
  # sets the arrival time
  def arrive
    @arrival_time = Time.now
  end
  
  # checks to see if both copies of the ticket have departed
  def in_flight?
    !(@first_departure_time.nil? && @second_departure_time.nil?)
  end
  
  # takes two locaiton strings, geocodes them, and assigns them to the object
  def set_locations(origin, destination)
    geocoder = GoogleGeocode.new 'ABQIAAAA5FcJvXKhmrpf2jr99XJHVxQtSeJwZvZ8w8cIIwDGWX74rdr8MBQGmbfUzIRlJEOqI4D1Hha0dob5tw'
    
    @origin = geocoder.locate(origin)
    # TODO Check for geocoder error
    
    @destination = geocoder.locate(destination)
    # TODO Check for geocoder error
  end
  
  # calculates the great circle distance between the two points
  def distance
    return false if @origin.nil? || @destination.nil?
    
    # TODO Calculate great circle distance between two points
  end
  
  # calculates the velocity between origin and destination
  # based on their distance and the time between 
  # @second_departure_time and @arrival_time
  def velocity
    # TODO calculate velocity
  end
  
  # calculates the method of transportation based on the velocity
  def transport
    # TODO calculate method of transport
  end
end