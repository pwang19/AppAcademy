def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum / arr.length.to_f
end

def repeat(str, num)
    result = ''
    num.times { result += str }
    result
end

def yell(str)
    str.upcase + '!'
end

def alternating_case(str)
    arr = str.split()
    (0..arr.length-1).each do |index|
        index.even? ? arr[index] = arr[index].upcase : arr[index] = arr[index].downcase
    end
    arr.join(' ')
end