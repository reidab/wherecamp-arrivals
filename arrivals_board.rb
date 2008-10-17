# acts kind of like a controller between the Ticket model and the UI
class ArrivalsBoard
  attr_accessor :tickets
  attr_accessor :window
  attr_accessor :stack
  
  def initialize
    @tickets = TicketPool.load
  end
end