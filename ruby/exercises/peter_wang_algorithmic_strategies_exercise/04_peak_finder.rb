# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(arr)
    result = []
    
    return result if arr.length == 0 # no peak if no elements
    return arr if arr.length == 1 # if one element, peak by default

    result << arr[0] if arr[0] > arr[1] # checks if first index is peak
    (1..arr.length-2).each do |index|
        result << arr[index] if arr[index] > arr[index-1] && arr[index] > arr[index+1]
    end
    result << arr[-1] if arr[-1] > arr[-2] # checks if last index is peak
    result
end

p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]
p peak_finder([1, 3])               # => [3]
p peak_finder([3, 1])               # => [3]
