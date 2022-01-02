def hipsterfy(word)
    word = word.reverse
    word.each_char { |char| 
        if 'aeiou'.include?(char)
            word[word.index(char)] = ''
            break if true
        end
    }
    word.reverse
end

def vowel_counts(string)
    hash = Hash.new(0)
    string.each_char { |char| hash[char.downcase] += 1 if 'aeiou'.include?(char.downcase)}
    hash
end

def caesar_cipher(message, num)
    alphabet = 'abcdefghijklmnopqrstuvwxyz'
    cipher = ''
    message.each_char { |char| 
        if alphabet.index(char) != nil
            cipher += alphabet[(alphabet.index(char)+num) % alphabet.length] if alphabet.index(char) != nil
        else
            cipher += char
        end
        }
    cipher
end