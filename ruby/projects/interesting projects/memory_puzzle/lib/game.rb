require_relative 'board.rb'

class Game
    def initialize(board_length, board_width)
        @board = Board.new(board_length, board_width)
        @previous_guess = nil
    end

    def play
        @board.populate
        while @board.won? == false
            system('clear')
            @board.render
            p 'make a guess using format X Y --> '
            begin
                guess = gets.chomp
                x_coord = guess[0..guess.index(' ')-1].to_i
                y_coord = guess[guess.index(' ')..-1].to_i
                card = @board.getCard([x_coord, y_coord])
                make_guess([x_coord, y_coord]) if card.to_s != nil && card.up == false
            rescue
                p 'Improper input'
                sleep(1)
            end
        end
        @board.render
        p 'game over!'
    end

    def make_guess(position)
        if @previous_guess == nil
            @previous_guess = @board.reveal(position)
        else
            current_guess = @board.reveal(position)
            if @previous_guess.to_s != current_guess.to_s
                system('clear')
                @board.render
                sleep(4)
                @previous_guess.hide
                current_guess.hide
            end
            @previous_guess = nil
        end
    end
end