# handles persistance of the pool of active tickets
class TicketPool < Array
  def find_by_number(number)
    select{ |v| v.number == number }
  end
  
  def find_or_create_by_number(number)
    find = find_by_number(number)
    if find.empty? 
      self << ticket = Ticket.new(number)
      return [ticket]
    else 
      return find
    end
  end
  
  def reset
    self.delete_if { |x| true }
  end
  
  def reset!
    reset
    save
  end
  
  def save
    file = File.new('tickets.txt','w')
    file.write Marshal.dump(self)
    file.close
    return self
  end

  def load
    if File.exist?('tickets.txt')
      file = File.open('tickets.txt','r')
      self.reset
      loaded = Marshal.load file.read
      loaded.each_index{ |i| self[i] = loaded[i] }
      file.close
    end
    return self
  end
  
  def self.load
    self.new.load
  end
end