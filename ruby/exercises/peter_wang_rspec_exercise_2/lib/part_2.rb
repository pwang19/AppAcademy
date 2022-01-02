def palindrome?(string)
    (0..string.length / 2).each do |index|
        return false if string[index] != string[string.length-1 - index]
    end
    true
end

def substrings(string)
    subs = []
    (0..string.length-1).each do |index1|
        (index1..string.length-1).each do |index2|
            subs.append(string[index1..index2])
        end
    end
    subs
end

def palindrome_substrings(string)
    substrings(string).filter { |str| str.length > 1 && palindrome?(str)}
end