require_relative 'card.rb'

class Board
    attr_reader :rows

    def initialize(length, width)
        @rows = Array.new(width) { Array.new(length, :blank)}
        @size = length * width
    end

    #populate should fill the board with a set of shuffled Card pairs
    def populate
        card_values = generate_card_values
        (0..@rows.length-1).each do |row|
            (0..@rows[0].length-1).each do |col|
                randIndex = rand(card_values.length)
                @rows[row][col] = Card.new(card_values.delete_at(randIndex))
            end
        end
    end

    def generate_card_values
        result = []
        alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        if @size < 53
            2.times { |x| (0..@size/2-1).each { |card| result.append(alphabet[card])}}
        else
            2.times { |x| (0..@size/2-1).each { |card| result.append(alphabet[card / 26] + alphabet[card % 26])}}
        end
        result
    end

    #render should print out a representation of the Board's current state
    def render
        print ' '
        (0..@rows[0].length-1).each { |n| print ' ' + n.to_s }
        p ''
        (0..@rows.length-1).each do |row|
            print row.to_s
            (0..@rows[0].length-1).each do |col|
                card = @rows[row][col]
                if card.to_s == nil
                    print ' 0'
                elsif card.up 
                    print ' ' + card.to_s
                else 
                    print '  '
                end
            end
            puts ''
        end
    end
    #won? should return true if all cards have been revealed.
    def won?
        @rows.each do |row|
            row.each do |card|
                return true if card.to_s == nil # in case the board has an odd number of positions
                return false if card.up == false
            end
        end
        true
    end

    #reveal should reveal a Card at guessed_pos (unless it's already face-up, in which case the method should do nothing). It should also return the value of the card it revealed (you'll see why later).
    def reveal(guessed_pos)
        card = @rows[guessed_pos[0]][guessed_pos[1]]
        card.reveal
        card
    end

    def getCard(position)
        @rows[position[0]][position[1]]
    end
end