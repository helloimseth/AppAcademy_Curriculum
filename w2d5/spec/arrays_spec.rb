require 'rspec'
require 'arrays'

describe '#stock_picker' do
  it 'takes an array' do
    expect{ stock_picker(1) }.to raise_error(ArgumentError)
  end

  it 'returns a pair of indices whose elements are most different' do
    stocks = [5, 2, 6, 4, 3]

    expect(stock_picker(stocks)).to eq([1,2])
  end

end

describe "#my_transpose" do
  it "takes an array" do
    expect{ my_transpose(1) }.to raise_error(ArgumentError)
  end

  it "returns the array transposed" do
    rows = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ]

    cols = [
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]
    ]

    expect(my_transpose(rows)).to eq(cols)
  end
end


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

  describe '#won?' do
    it 'returns true when peg 1 is empty and either peg2 or peg 3 is also empty' do
      tower.peg1, tower.peg2 = tower.peg2, tower.peg1

      expect(tower.won?).to be(true)
    end

    it 'returns false otherwise' do
      expect(tower.won?).to be(false)
    end
  end

  describe '#display' do
    it 'prints the render to screen' do
      output = tower.render

      expect { tower.display }.to output(output).to_stdout
    end
  end
end
