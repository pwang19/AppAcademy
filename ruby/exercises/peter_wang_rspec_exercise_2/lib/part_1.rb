def partition(arr, num)
    subarr1 = []
    subarr2 = []

    arr.each do |n| 
        n < num ? subarr1.push(n) : subarr2.push(n)
    end
    [subarr1, subarr2]
end

def merge(hash1, hash2)
    newHash = hash1.clone
    hash2.each do |key, val|
        newHash[key] = val
    end
    newHash
end

def censor(sentence, words)
    sentence.split().map { |word| 
        words.include?(word.downcase) ? word.gsub(/[aeiouAEIOU]/, '*') : word
    }.join(' ')
end

def power_of_two?(num)
    power = 0
    while 2 ** power < num
        power += 1
    end
    2 ** power == num
end