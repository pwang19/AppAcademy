require 'open-uri'
require 'set'
require_relative 'player.rb'
require_relative 'ai_player.rb'

class Game
    attr_reader :current_player, :previous_player, :players

    # players is a hash with key value pairs: { player name (string) => human player (boolean) }
    def initialize(players)
        @players = {}
        players.each { |name, human | human ? @players[Player.new(name)] = 0 : @players[AIPlayer.new(name, players.length)] = 0 }
        @current_player = @players.keys[0]
        @previous_player = nil
        @fragment = ''
        @dictionary = open('https://assets.aaonline.io/fullstack/ruby/projects/ghost/dictionary.txt') {|f| f.read }.split("\n").to_set
        @current_possible_words = @dictionary.flatten #duplicates original dictionary
    end

    def play_round
        while take_turn(@current_player)
        end
        @players[@current_player] += 1
        @current_possible_words = @dictionary.flatten
        @fragment = ''
    end

    def next_player!
        @previous_player = current_player
        @current_player = @players.keys[(@players.keys.index(@current_player)+1) % @players.length]
    end

    # gets a string from the player until a valid play is made; then updates the fragment and checks against the dictionary. You may also want to alert the player if they attempt to make an invalid move (or, if you're feeling mean, you might cause them to lose outright).
    def take_turn(player)
        guess = player.guess(@fragment, @current_possible_words)
        while !valid_play?(guess)
            guess = player.alert_invalid_guess
        end
        @fragment += guess
        if @current_possible_words.include?(@fragment)
            p 'Round finished! Loser is: '+ @current_player.name + ' and Word created: ' + @fragment
            return false
        end
        @current_possible_words.keep_if { |word| word[0..@fragment.length-1] == @fragment}
        p 'Current fragment is: '+ @fragment + ' and current player is: '+ next_player!.name
        p 'There are ' + @current_possible_words.length.to_s + ' possible words'
        true
    end

    # Checks that string is a letter of the alphabet and that there are words we can spell after adding it to the fragment
    def valid_play?(char)
        alphabet = 'abcdefghijklmnopqrstuvwxyz'
        return false if char == nil or !alphabet.include?(char[0].downcase)
        update = @fragment + char[0].downcase
        @current_possible_words.each { |word| return true if word[0..update.length-1] == update }
        return false
    end

    def losses(losses)
        losses == 0 ? 'no losses!' : ' GHOST'[1..losses]
    end

    def record
        @players.each { |player, losses| p player.name + ' has ' + losses(losses) }
    end

    def run
        p 'Ghost game'
        p @current_player.name + ' is playing first.'
        while @players.length > 1
            p 'New round starts now with ' + @current_player.name + ' playing first.'
            play_round
            p 'Current Standings'
            record
            if @players[@current_player] == 5
                next_player!
                p @previous_player.name + ' has lost!'
                @players.delete(@previous_player)
            end
        end
        p 'Game over! The winner is: ' + @current_player.name


    end

end

Game.new({'AI1' => false, 'AI2' => false, 'AI3' => false}).run