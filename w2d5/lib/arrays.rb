def stock_picker(stock_prices)
  raise ArgumentError.new unless stock_prices.is_a?(Array)
  best_diff = 0
  best_days = []

  stock_prices.each_with_index do |price1, day1|
    stock_prices.each_with_index do |price2, day2|
      next if day2 < day1
      if price2 - price1 > best_diff
        best_days = [day1, day2]
        best_diff = price2 - price1
      end
    end
  end

  best_days
end

def my_transpose(arr)
  raise ArgumentError.new unless arr.is_a?(Array)

  trans_arr = Array.new(arr.count) { Array.new }

  arr.each_index do |idx|
    arr[idx].each_index do |idx2|
      trans_arr[idx2][idx] = arr[idx][idx2]
    end
  end

  trans_arr
end

class TowersOfHanoi
  attr_accessor :peg1, :peg2, :peg3

  def initialize
    @peg1 = [3, 2, 1]
    @peg2 = []
    @peg3 = []
  end

  def pegs
    [@peg1, @peg2, @peg3]
  end

  def display
    print render
  end

  def render
    max_height = pegs.map(&:length).max

    lines = []
    (max_height-1).downto(0) do |level|
      lines << pegs.map {|peg| peg[level] ? peg[level] : ""}.join("\t")
    end

    lines.join("\n")
  end

  def move(peg1, peg2)
    if peg1.empty? || (!peg2.empty? && peg2.last < peg1.last)
      raise StandardError.new
    end
    peg2 << peg1.pop
  end

  def won?
    peg1.empty? && (peg2.empty? || peg3.empty?)
  end

  def get_input
    puts "Pick a peg"
    i = gets.chomp
    Integer(i)
  end

  def play
    display

  end

end

class Array
  def my_uniq
    uniqs = []

    self.each do |el|
      uniqs << el unless uniqs.include?(el)
    end

    uniqs
  end

  def two_sum
    two_sum = []

    self.each_with_index do |el, idx1|
      (idx1+1...self.count).each do |idx2|
        two_sum << [idx1, idx2] if el + self[idx2] == 0
      end
    end

    two_sum
  end


end
