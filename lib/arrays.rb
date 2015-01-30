class TowersOfHanoi

  def initialize
    peg1 = [3, 2, 1]
    peg2 = []
    peg3 = []
  end

  def render
    "hello"
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
