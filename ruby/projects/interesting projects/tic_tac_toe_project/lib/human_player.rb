class HumanPlayer
    attr_reader :mark_value

    def initialize(mark_value)
        @mark_value = mark_value
    end

    def get_position(legal_positions)
        puts 'Enter a position by entering 2 numbers separated by a space.'
        puts 'The first number is the row, and the second is the column.'
        print 'Note that non-numbers will be interpreted as 0. --> '
        input = gets.chomp

        while legal_positions.index(process_input(input)) == nil
            print 'Invalid move! Try again. Input ->'
            input = gets.chomp
        end
        process_input(input)
    end

    def process_input(string)
        string.split.map(&:to_i)[0..1]
    end

end