class HumanPlayer
    def prompt
        p 'make a guess using format X Y --> '
        get_input
    end

    def get_input
        begin
            guess = gets.chomp
            x_coord = guess[0..guess.index(' ')-1].to_i
            y_coord = guess[guess.index(' ')..-1].to_i
            [x_coord, y_coord]
        rescue
            p 'invalid guess.'
            get_input
        end
    end
end