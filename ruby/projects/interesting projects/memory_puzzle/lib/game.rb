require_relative 'board.rb'
require_relative 'human_player.rb'

class Game
    def initialize(board_length, board_width, human_player)
        @board = Board.new(board_length, board_width)
        @previous_guess = nil
        @player = human_player ? HumanPlayer.new : HumanPlayer.new
    end

    def play
        @board.populate
        while @board.won? == false
            system('clear')
            @board.render
            position = @player.prompt
            while !valid_guess(position)
                position = @player.prompt
            end
            card = @board.getCard(position)
            make_guess(position) if card.to_s != nil && card.up == false
        end
        @board.render
        p 'game over!'
    end

    def valid_guess(position)
        x, y = position
        x >= 0 and y >= 0 and y < @board.rows.length and x < @board.rows[0].length
    end

    def make_guess(position)
        if @previous_guess == nil
            @previous_guess = @board.reveal(position)
        else
            current_guess = @board.reveal(position)
            if @previous_guess.to_s != current_guess.to_s
                system('clear')
                @board.render
                sleep(2)
                @previous_guess.hide
                current_guess.hide
            end
            @previous_guess = nil
        end
    end
end