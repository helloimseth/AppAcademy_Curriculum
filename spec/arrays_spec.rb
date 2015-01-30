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
  let(:tower) { TowersOfHanoi.new }

  describe '#render' do

    it 'transforms three arrays into one multi-line string' do
      expect(tower.render).to be_a(String)
    end

    it 'outputs the correctly formatted string' do
      string = "1\t\t\n2\t\t\n3\t\t"

      expect(tower.render).to eq(string)
    end
  end

  describe '#move' do
    it 'should take 2 arguments' do
      expect{tower.move(1,2,3)}.to raise_error(ArgumentError)
    end

    it 'takes the top disk from first peg' do
      top_disk = tower.peg1.last
      tower.move(tower.peg1, tower.peg2)

      expect(tower.peg1.last).to_not be(top_disk)
    end

    it 'replaces moves that disk to the second peg' do
      tower.move(tower.peg1, tower.peg2)

      expect(tower.peg2.last).to be(1)
    end

    it 'should not allow a larger disc to be moved onto a smaller disk' do
      tower.move(tower.peg1, tower.peg2)

      expect{tower.move(tower.peg1, tower.peg2)}.to raise_error
    end

    it 'should not allow moves from an empty peg' do
      expect{tower.move(tower.peg2, tower.peg1)}.to raise_error
    end
  end

end
