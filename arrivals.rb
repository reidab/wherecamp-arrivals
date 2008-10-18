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
  $board.window = window(:title => "Arrivals Board") do
    background black
    $board.stack = stack(:stroke => white) do
      $board.tickets.select{|t| !t.origin.nil?}.sort{|a,b| a.arrival_time<=>b.arrival_time}.each do |ticket|
        transport = ticket.transport || 'Something Mysterious'
        para "#{ticket.number} : #{transport.upcase} from #{ticket.origin.address.upcase} to #{ticket.destination.address.upcase}", :stroke => white
      end
    end
  end
  
  stack do
    para("Ticket Number", :size => 10).displace(0, 13)
    @departure_number = edit_line :width => 100
    @depart_button = button "Log Departure", :margin_top => 10
    
    @depart_button.click {
      $board.departure(@departure_number.text.to_i)
      @departure_number.text=''
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
      $board.arrival(@arrival_number.text.to_i, @origin.text, @destination.text)
      @arrival_number.text=''
      @origin.text=''
      @destination.text=''
    end
    
    button "display test" do
      $board.post_to_board('test')
    end
    
  end
end
