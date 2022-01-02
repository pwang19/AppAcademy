require_relative "room"

class Hotel
  def initialize(name, rooms)
    @name = name
    @rooms = {}
    rooms.each { |key, value| @rooms[key] = Room.new(value)}
  end

  def name
    @name.split().map{ |word| word[0].upcase + word[1..-1].downcase}.join(' ')
  end

  def rooms
    @rooms
  end

  def room_exists?(name)
    @rooms.include?(name)
  end

  def check_in(person, room)
    if !room_exists?(room)
        p 'sorry, room does not exist'
    else
        if @rooms[room].add_occupant(person) 
            p 'check in successful'
        else 
            p 'sorry, room is full'
        end
    end
end

def has_vacancy?
    @rooms.each_value { |room| return true if !room.full? }
    false
end

def list_rooms
    @rooms.each { |name, room| puts "#{name} : #{room.available_space}" }
end

end
