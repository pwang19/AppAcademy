class Flight 
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.length >= @capacity
    end

    def board_passenger(passenger)
        @passengers << passenger if !full? and passenger.has_flight? @flight_number
    end

    def list_passengers
        @passengers.map { |passenger| passenger.name}
    end

    def [](index)
        @passengers[index]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end