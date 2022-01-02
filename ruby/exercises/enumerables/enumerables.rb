module Enumerable
    def my_each(&blk)
        index = 0
        while index < self.length
            blk.call(self[index])
            index += 1
        end
        self
    end

    def my_select(&blk)
        selection = []
        self.my_each { |el| selection << el if blk.call(el)}
        selection
    end

    def my_reject(&blk)
        self - self.my_select(&blk)
    end

    def my_any?(&blk)
        self.my_select(&blk).length > 0
    end

    def my_all?(&blk)
        self.my_select(&blk) == self
    end
end

class Array
    def my_flatten
        result = [] 
        self.my_each { |el| el.class == Array ? result += el.my_flatten : result << el }
        result
    end

    def my_zip(*arr)
        result = Array.new(self.length) { Array.new(arr.length + 1, nil)}
        (0..result.length-1).each do |index1|
            (0..result[0].length-1).each do |index2|
                result[index1][index2] = arr[index2-1][index1]
            end
            result[index1][0] = self[index1]
        end
        result
    end

    def my_rotate(n = 1)
        result = []
        (0..self.length-1).each {|index| result << self[(index + n) % self.length] }
        result
    end

    def my_join(seperator = '')
        result = ''
        self.my_each { |el| result += el + seperator }
        seperator == '' ? result : result[0..-2]
    end

    def my_reverse
        result = []
        self.my_each { |el| result.unshift(el) }
        result
    end
end