require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player

    def initialize(length)
        @player = Player.new
        @board = Board.new(length)
        @remaining_misses = @board.size / 2
    end

    def start_game
        @board.place_random_ships
        @board.print
        print @board.num_ships
    end

    def lose?
        if @remaining_misses <= 0
            print 'you lose'
            return true
        else
            false
        end
    end

    def win?
        if @board.num_ships == 0
            print 'you win'
            return true
        else
            false
        end
    end

    def game_over?
        win? or lose?
    end

    def turn
        @remaining_misses -= 1 if !@board.attack(@player.get_move)
        @board.print
        print @remaining_misses
    end


end
