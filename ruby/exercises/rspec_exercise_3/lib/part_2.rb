def element_count(array)
    counts = Hash.new(0)
    array.each { |el| counts[el] += 1}
    counts
end

def char_replace!(string, replace)
    string.each_char.with_index { |char,index| string[index] = replace[char] if replace.has_key?(char)}
end

def product_inject(nums)
    nums.inject(&:*)
end