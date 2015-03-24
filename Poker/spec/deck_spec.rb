require 'deck'

describe Deck do
  let(:deck) { Deck.new }

  test_cards = [ Card.new(:two, :diamonds),
    Card.new(:three, :spades) ]

  describe '#initialize' do
    it "should have 52 cards" do
      expect(deck.cards.count).to eq(52)
    end

    it "should have no duplicates" do
      expect(deck.cards.uniq.count).to eq(52)
    end

    it "should shuffle itself automatically" do
      expect(deck).to receive(:shuffle!)
      deck.send(:initialize)
    end
  end

  describe "#count" do
    it "counts the cards in deck" do
      expect(deck.count).to eq(52)
    end
  end

  describe '#take' do
    it "return n cards from the deck" do
      deck.cards = test_cards.dup

      expect(deck.take(2)).to eq(test_cards)
    end

    it "reduces count by n" do
      deck.take(2)

      expect(deck.count).to eq(50)
    end
  end

  describe '#take_back' do
    it "takes an array" do
      expect { deck.take_back(4) }.to raise_error(ArgumentError)
    end

    it "takes an array of cards" do
      expect { deck.take_back([1,2,3,4]) }.to raise_error(ArgumentError)
    end

    it "puts cards at the end of the deck" do
      drawn = deck.take(1)
      deck.take_back(drawn)

      expect(deck.cards.include?(drawn[0])).to be(true)
    end
  end

  describe '#shuffle!' do
    it 'shuffles! the deck' do
      preshuffle = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).to_not eq(preshuffle)
    end
  end
end
