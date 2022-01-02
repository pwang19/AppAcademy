# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    return nil if self.length.zero?
    self.sort[-1] - self.sort[0]
  end

  def average
    return nil if self.length.zero?
    self.sum(0.0) / self.length
  end

  def median
    return nil if self.length.zero?
    self.length % 2 == 0 ? (self.sort[self.length / 2] + self.sort[self.length / 2 - 1]) / 2.0 : self.sort[self.length / 2]
  end

  def counts
    hash = Hash.new(0)
    self.each { |el| hash[el] += 1 }
    hash
  end

  def my_count(val)
    count = 0
    self.each { |el| count += 1 if el == val }
    count
  end

  def my_index(val)
    self.each_with_index { |el, index| return index if el == val}
    nil
  end

  def my_uniq
    new_arr = []
    self.each { |el| new_arr << el if !new_arr.include?(el)}
    new_arr
  end

  def my_transpose
    new_arr = Array.new(self.length) {Array.new(self.length)}
    self.each_with_index do |subarr, x|
        subarr.each_with_index do |el, y|
            new_arr[y][x] = self[x][y]
        end
    end
    new_arr
    end
end

# 0 1 2 3-> arr[0]
# 0 1 2 3
# 0 1 2 3
# 0 1 2 3


#0 0 0 -> arr[0]
#1 1 1
#2 2 2
