class AIPlayer
    attr_reader :name

    def initialize(name, num_players)
        @name = name
        @num_players = num_players
    end

    def guess(fragment, possible_words)
        word_bank = []
        possible_words.each { |word| word_bank << word[fragment.length..-1] }
        word_bank.filter! { |word| word.length % @num_players == 0}
        if word_bank == nil or word_bank == []
            return possible_words.to_a[rand(possible_words.size)][fragment.length]
        else
            return word_bank[rand(word_bank.length)][0]
        end
    end

end