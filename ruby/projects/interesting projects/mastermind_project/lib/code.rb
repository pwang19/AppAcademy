class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(pegs)
    pegs.each { |peg| return false if !POSSIBLE_PEGS.has_key?(peg.upcase) }
    return true
  end

  def initialize(pegs)
    Code.valid_pegs?(pegs) ? @pegs = pegs.map(&:upcase) : (raise 'Error. Invalid input. Please use colors: RGBY')
  end

  def self.random(length)
    Code.new(Array.new(length) { |index| POSSIBLE_PEGS.keys.sample })
  end

  def self.from_string(pegs)
    Code.new(pegs.split(''))
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(code)
    match = 0
    @pegs.each_with_index { |peg, index| match += 1 if peg == code.pegs[index] }
    match
  end

  def num_near_matches(code)
    this_pegs_count = getCounts(@pegs)
    code_pegs_count = getCounts(code.pegs)
    hash = code_pegs_count.merge(this_pegs_count) { |key, code_val, pegs_val| code_val < pegs_val ? code_val : pegs_val }
    count = 0
    hash.each_value { |val| count += val }
    count - num_exact_matches(code)
  end

  def getCounts(code)
    result = {'R'=> 0, 'G'=>0, 'B'=>0, 'Y'=>0 }
    code.each { |peg| result[peg] += 1 }
    result
  end

  def ==(code)
    num_exact_matches(code) == self.pegs.length and code.pegs.length == self.pegs.length
  end

end
