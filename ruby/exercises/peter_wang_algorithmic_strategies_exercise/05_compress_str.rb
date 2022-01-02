# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    compress = ''
    count = 1

    (1..str.length-1).each do |index|
        if str[index-1] == str[index]
            count += 1
        else
            compress += count.to_s if count > 1
            compress += str[index-1]
            count = 1
        end
        if index == str.length-1
            compress += count.to_s if count > 1
            compress += str[index]
        end
    end
    compress
end


p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
