require 'card'

describe Card do
  let(:card) { Card.new(:three, :clubs) }

  it "initializes with a value" do
    expect(card.value).to be(:three)
  end

  it "initializes with a suit" do
    expect(card.suit).to be(:clubs)
  end

  describe "#<=>" do
    let(:card1) { Card.new(:four, :clubs) }
    let(:card2) { Card.new(:three, :hearts) }

    it 'compares cards by value' do
      expect(card1<=>card2).to be(1)
    end

    it 'compares cards of equal value by suit' do
      expect(card<=>card2).to be(1)
    end
  end
end
