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
    @tickets.save
  end
  
  def arrival(number, origin=nil, destination=nil)
    @tickets.find_or_create_by_number(number).first.arrive
    @tickets.save
  end
    
end