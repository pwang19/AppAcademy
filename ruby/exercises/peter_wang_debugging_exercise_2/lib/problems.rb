# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

def largest_prime_factor(num)
    result = 1
    (2..num).each do |factor|
        result = factor if num % factor == 0 && isPrime?(factor)
    end
    result
end

def isPrime?(num)
    return true if num < 2
    (2..num-1).each do |factor|
        return false if num % factor == 0
    end
    true
end

def unique_chars?(string)
    chars = Hash.new(0)
    string.each_char do |char|
        chars[char] == 0 ? chars[char] += 1 : (return false)
    end
    true
end

def dupe_indices(arr)
    hash = {}
    arr.each_with_index do |num, index|
        hash[num] == nil ? hash[num] = [index] : hash[num] = hash[num].append(index)
    end
    hash.select { |key, val| val.length > 1 }
end

def ana_array(arr1, arr2)
    return false if arr1.length != arr2.length

    arr1.each do |el|
        arr2.index(el) == nil ? (return false) : arr2.delete_at(arr2.index(el))
    end
    true
end
