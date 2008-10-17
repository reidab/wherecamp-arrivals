Shoes.setup do
  gem 'google-geocode'
end

require 'google_geocode'
require 'ticket'
require 'ticket_pool'
require 'arrivals_board'
$board = ArrivalsBoard.new

Shoes.app(:title => "Control Panel") do

  @controls = self
  $board.window = window "Arrivals Board" do
    $board.stack = stack
  end
  
  stack do
    para("Ticket Number", :size => 10).displace(0, 13)
    @departure_number = edit_line :width => 100
    @depart_button = button "Log Departure", :margin_top => 10
    
    @depart_button.click {
      $board.departure(@departure_number.text.to_i)
    }
          
    para("Ticket Number", :size => 10).displace(0, 13)
    @arrival_number = edit_line :width => 100
    
    flow do
      stack :width => 200 do
        para("Origin", :size => 10).displace(0, 13)
        @origin = edit_line
      end
      stack :width => 200, :margin_left => 20 do
        para("Destination", :size => 10).displace(0, 13)
        @destination = edit_line
      end
    end
    
    button "Log Arrival", :margin_top => 10 do
      $board.arrival(@arrival_number.text.to_i)
    end
    
  end
end

