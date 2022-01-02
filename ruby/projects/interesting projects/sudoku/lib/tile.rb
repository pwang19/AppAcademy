class Tile
    def initialize(value, given)
        @value = value
        @given = given
    end

    def to_s
        @value
    end

    def update_value(value)
        @value = value if !@given
    end

end