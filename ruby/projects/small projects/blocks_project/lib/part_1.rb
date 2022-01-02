require "byebug"

def select_even_nums(arr)
    arr.select(&:even?)
end

def reject_puppies(arr)
    arr.reject {|hash| hash['age'] <= 2 }
end

def count_positive_subarrays(arr2d)
    arr2d.count {|arr| arr.sum > 0}
end

def aba_translate(string)
    result = ''
    string.each_char { |char| 'aeiou'.include?(char) ? result += char + 'b' + char : result += char}
    result
end

def aba_array(arr)
    arr.map {|word| aba_translate(word)}
end
