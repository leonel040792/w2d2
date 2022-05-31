require_relative "room"

class Hotel

    attr_reader :rooms
    def initialize(name, hash)
        @name= name
        @rooms=Hash.new()
        hash.each {|room_name,capacity| @rooms[room_name]= Room.new(capacity)}
    end

    def name
       capitalized = @name.split(" ").map{|word| word.capitalize}.join(" ")
       capitalized
    end

    def room_exists?(room)
        @rooms.key?(room)
    end

    def check_in(person, room)
        if room_exists?(room)
            if @rooms[room].add_occupant(person)
                puts 'check in successful'
            else
                puts 'sorry, room is full'
            end
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @rooms.any?{|k,v| !v.full?}
    end

    def list_rooms
    @rooms.each {|room, instance| puts room + " " + instance.available_space.to_s}
    end
  
end
