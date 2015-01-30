require 'arrays'

describe Array do
  describe '#my_uniq' do
    it 'removes duplicate entries from an array' do
      array = [1, 2, 1, 3, 3]

      expect(array.my_uniq).to eq([1,2,3])
    end
  end

  describe "#two_sum" do
    it 'finds all index pairs whose elements sum to zero' do
      array = [-1, 0, 2, -2, 1]

      expect(array.two_sum).to eq([[0, 4], [2, 3]])
    end
  end
end


# For Towers of Hanoi, focus on non-UI stuff first.
# #render
# #move
# #won?

describe TowersOfHanoi do
  describe '#render' do
    let(:tower) { TowersOfHanoi.new }

    it 'transforms three arrays into one multi-line string' do
      expect(tower.render).to be_a(String)
    end

    it 'outputs the correctly formatted string' do
      string = "1\t\t\n2\t\t\n3\t\t"

      expect(tower.render).to eq(string)
    end
  end

end
