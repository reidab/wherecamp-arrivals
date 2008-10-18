require 'rubygems'
require 'google_geocode'    # this is the google-geocode gem


# represents a trip, performs calculations  
# each ticket object represents a pair of physical tickets 
class Ticket
  

  
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
    
    r = 6371;
    d_lat = (@origin.latitude - @destination.latitude) * Math::PI / 180
    d_long = (@origin.longitude - @destination.longitude) * Math::PI / 180
    
    a = Math.sin(d_lat/2) * Math.sin(d_lat/2) +
            Math.cos(@destination.latitude * Math::PI / 180) * Math.cos(@origin.latitude * Math::PI / 180) * 
            Math.sin(d_long/2) * Math.sin(d_long/2); 
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
    d = r * c;
  end
  
  # calculates the velocity between origin and destination
  # based on their distance and the time between 
  # @second_departure_time and @arrival_time
  def velocity
    self.distance / ((@arrival_time - @second_departure_time) / 60)
  end
  
  # calculates the method of transportation based on the velocity
  def transport
    case velocity
    when 0..10
      'Tortoise Caravan'
    when 11..17
       'Palanquin'
     when 18..27
       'Elephant'
     when 28..40
       'Bicycle Rickshaw'
     when 41..56
       'Covered Wagon'
     when 57..75
       'Zeppelin'
     when 76..97
       'Omnibus'
     when 98..122
       'Steam Locomotive'
     when 123..150
       'Shinkansen'
     when 151..181
       'Concorde'
     when 181..999999
       'Ballistic Rocket Plane'
     end
  end
end