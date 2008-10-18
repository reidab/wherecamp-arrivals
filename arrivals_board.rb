# acts kind of like a controller between the Ticket model and the UI
class ArrivalsBoard
  attr_accessor :tickets  # a TicketPool of tickets
  attr_accessor :window   # the shoes app object for the output window
  attr_accessor :stack    # the shoes stack object for output
  
  def initialize
    @tickets = TicketPool.load
  end
  
  def departure(number)
    @tickets.find_or_create_by_number(number).first.depart
    debug "#{number} departed at #{Time.now}"
    @tickets.save
  end
  
  def arrival(number, origin=nil, destination=nil)
    ticket = @tickets.find_or_create_by_number(number).first
    ticket.arrive if ticket.arrival_time.nil?
    ticket.second_departure_time = ticket.first_departure_time if ticket.second_departure_time.nil?
    ticket.set_locations(origin, destination) if (!origin.nil? && !destination.nil?)
    debug "#{number} from #{ticket.origin.address} to #{ticket.destination.address} arrived at #{Time.now}"
    @tickets.save
    
    @stack.app do
      stack do
        transport = ticket.transport || 'Something Mysterious'
        para "#{ticket.number} : #{transport.upcase} from #{ticket.origin.address.upcase} to #{ticket.destination.address.upcase}", :stroke => white
      end
    end
  end
  
end