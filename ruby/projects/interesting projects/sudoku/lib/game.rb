require_relative 'board.rb'

class Game
    def initialize(filename = nil)
        @board = Board.new(Board.from_file(filename))
    end

    def play
        @board.render
        while !@board.solved?
            print 'Enter a coordinate X Y (in range 0-8), followed by a number 0-9, all separated by spaces. --> '
            begin
                input = gets.chomp.split.map(&:to_i)
                raise 'Exception' if input[2] < 0 or input[2] > 9
                update = @board.update_value([input[0], input[1]], input[2])
                p 'Error: Cannot modify a given value!' if !update
                @board.render
            rescue
                p 'Invalid input. Valid example: 1 2 3'
            end
        end
    end
end