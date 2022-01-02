require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game
    def initialize(board_size, players)
        @players = []
        players.each { |mark, is_computer| is_computer ? @players << ComputerPlayer.new(mark) :  @players << HumanPlayer.new(mark) }
        @current_player = @players[0]
        @board = Board.new(board_size)
    end

    def switch_turn
        @current_player = @players.rotate![0]
    end

    def play
        p "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        p "~~~~~~~~~Tic Tac Toe!~~~~~~~~~"
        p "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        while @board.empty_positions?
            p '~~~~~BOARD~~~~~'
            @board.print
            @board.place_mark(@current_player.get_position(@board.legal_positions), @current_player.mark_value)
            if @board.win?(@current_player.mark_value)
                @board.print
                p @current_player.mark_value.to_s + ' is the winner!'
                p 'Game Over!'
                return
            else 
                switch_turn
            end
            3.times { |x| puts '' }
        end
        @board.print
        p 'It is a draw!'
    end
end

Game.new(3, {'X': true, 'Y': true}).play