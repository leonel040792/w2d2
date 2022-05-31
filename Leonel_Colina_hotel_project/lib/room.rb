class Room
    attr_reader :capacity, :occupants
    def initialize(capacity)
        @capacity = capacity
        @occupants = []
    end

    def full?
        @capacity==@occupants.length
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(person)
        unless full?
            @occupants << person 
            return true
        end
        false
    end
end