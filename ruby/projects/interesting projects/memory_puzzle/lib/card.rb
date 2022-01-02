class Card
    attr_reader :up

    def initialize(value)
        @value = value
        @up = false
    end

    def hide
        @up = false
    end

    def reveal
        @up = true
    end

    def to_s
        @value
    end

    def ==(other_card)
        @value == other_card.to_s
    end
end