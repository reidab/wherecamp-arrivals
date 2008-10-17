# acts kind of like a controller between the Ticket model and the UI
class ArrivalsBoard
  attr_accessor :tickets
  
  def initialize
    @tickets = TicketPool.load
  end
end