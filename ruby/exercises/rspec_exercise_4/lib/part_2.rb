def proc_count(val, prcs)
    prcs.inject(0) { |count, prc| count + (prc.call(val) ? 1 : 0)}
end

def proper_factors(num)
    (1..num-1).filter {|n| num % n == 0}
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(n)
    result = []
    num = 1
    while result.length < n
        result.append(num) if perfect_number?(num)
        num += 1
    end
    result
end