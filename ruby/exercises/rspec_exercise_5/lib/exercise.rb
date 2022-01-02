def zip(*arr)
    zip = Array.new(arr[0].length) {Array.new()}
    arr.each { |a| a.each_with_index { |el, index| zip[index] << el }}
    zip
end

def prizz_proc(array, prc1, prc2)
    s1 = array.select(&prc1) 
    s2 = array.select(&prc2)
    elements = s1 + s2 - (s1 & s2)
    array.select { |el| elements.include?(el) }
end

def zany_zip(*arr)
    long = arr.inject(0) { |longest, curr| longest < curr.length ? longest = curr.length : longest }
    zip = Array.new(long) {Array.new(arr.length, nil)}
    arr.each_with_index { |a, index1| a.each_with_index { |el, index2| zip[index2][index1] = el }}
    zip
end

def maximum(arr, &prc)
    return nil if arr.empty?
    processed = arr.map(&prc)
    arr.reverse[processed.reverse.index(processed.max)]
end

def my_group_by(arr, &prc)
    # { |s| s.length }
    hash = Hash.new() { |h,k| h[k] = []}
    arr2 = arr.map(&prc)
    (0..arr.length-1).each { |index| hash[arr2[index]] << arr[index]}
    hash
end

def max_tie_breaker(array, prc, &blk)
    return nil if array.empty?
    processed = array.map(&blk)
    processed = array.select.with_index {|el, index| processed.max == processed[index]}
    processed = processed.map(&prc) if processed.count(processed.max) > 1
    processed[0]
end

def silly_syllables(sentence)
    vowels = Hash.new() { |h,k| h[k] = []}
    sentence.split().map { |word| word.each_char.with_index { |char, index| vowels[word] << index if 'aeiou'.include?(char)}}
    result = sentence.split().map { |word| vowels[word].length < 2 ? word : word[vowels[word][0]..vowels[word][-1]] }
    result.join(' ')

end