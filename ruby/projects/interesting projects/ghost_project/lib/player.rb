class Player 
    attr_reader :name

    def initialize(name)
        @name = name
    end

    def guess(*args)
        print 'Input a letter to add to the existing fragment --> '
        gets.chomp[0]
    end

    def alert_invalid_guess
        print 'Invalid guess. '
        guess
    end
end