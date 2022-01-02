def is_prime?(num)
    return false if num < 2
    (2..num-1).each { |n| return false if num % n == 0 }
    true
end

def nth_prime(n)
    erosthenes_sieve(n)[n-1]
end

def erosthenes_sieve(n)
    sieve = Array.new(n ** 2) {|i| i + 2 }
    (2..n).each do |factor|
        sieve = sieve.select { |num| num == factor or num % factor != 0 }
    end
    sieve
end

def prime_range(min, max)
    erosthenes_sieve(Math.sqrt(max).floor + 1).filter { |num| num >= min && num <= max }
end