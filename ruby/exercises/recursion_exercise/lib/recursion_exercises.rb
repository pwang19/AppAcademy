def range(start_num, end_num)
    return [] if start_num >= end_num
    [start_num, range(start_num + 1, end_num)].flatten
end

def range_iterative(start_num, end_num)
    result = []
    (start_num..end_num-1).each { |n| result << n}
    result
end


def exp_recursion_1(b, n)
    return 1 if n == 0
    b * exp_recursion_1(b, n - 1)
end

def exp_recursion_2(b,n)
    return 1 if n == 0
    return b if n == 1
    return exp_recursion_2(b, n / 2) ** 2 if n.even?
    b * (exp_recursion_2(b, (n - 1) / 2) ** 2)
end

class Array
    def deep_dup
        result = []
        self.each do |el|
            el.class == Array ? result.append(el.deep_dup) : result.append(el)
        end
        result
    end
end

def fibonocci_iterative(n)
    return [] if n < 1
    return [1] if n == 1
    result = [1, 1]
    return result if n == 2
    (3..n).each do |times|
        result.append(result[-1] + result[-2])
    end
    result
end

# just gives you the nth fib number
def fibonocci_recursive(n)
    return 0 if n < 1
    return 1 if n < 3 
    fibonocci_recursive(n-1) + fibonocci_recursive(n-2)
end

def bsearch(array, target)
    raise 'not found' if array.length == 1 && array[0] != target
    index = array.length / 2
    p array
    return index if array[index] == target
    array[index] > target ? bsearch(array[0..index], target) : bsearch(array[index..-1], target) + index
end

def merge_sort(array)
    return array if array.length < 2
    subarrs = []
    current_subarr = []
    array.each do |el|
        if current_subarr.length == 0 or current_subarr[-1] <= el
            current_subarr.append(el)
        else
            subarrs.append(current_subarr)
            current_subarr = [el]
        end
    end
    subarrs.append(current_subarr)
    while subarrs.length > 1
        subarrs.append(merge(subarrs.shift, subarrs.shift))
    end
    subarrs[0]
end

def merge(arr1, arr2)
    result = []
    i1 = 0
    i2 = 0
    while i1 < arr1.length and i2 < arr2.length
        if arr1[i1] < arr2[i2]
            result << arr1[i1]
            i1 += 1
        else
            result << arr2[i2]
            i2 += 1
        end
    end
    if i1 < arr1.length
        result.concat(arr1[i1..-1])
    else
        result.concat(arr2[i2..-1])
    end
    result
end

def subsets(arr)
    return arr if arr.length == 0
    result = [arr]
    (0..arr.length-1).each do |index|
        copy = arr.deep_dup
        copy.delete_at(index)
        result += subsets(copy)
    end
    result.uniq
end

def permutations(arr)
end

def greedy_make_change
end