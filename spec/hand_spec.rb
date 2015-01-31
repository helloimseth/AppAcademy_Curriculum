require 'hand'
require 'card'

describe Hand do
  let(:deck) { double("deck") }
  before { allow(deck).to receive(:take).with(5).and_return(random_hand) }
  let(:hand) { Hand.draw_cards(deck) }
  let(:hand2) { Hand.draw_cards(deck) }
  let(:random_hand) { Array.new(5) { Card.new(nil, nil, true) } }

  let(:sorted) { [ Card.new(:four,  :clubs),
    Card.new(:five,  :hearts),
    Card.new(:ace,   :spades),
    Card.new(:three, :hearts),
    Card.new(:three, :spades) ] }
  let(:full_house) { [ Card.new(:three, :hearts),
    Card.new(:three, :spades),
    Card.new(:three,  :clubs),
    Card.new(:four,  :hearts),
    Card.new(:four,   :spades) ] }
  let(:straight) { [ Card.new(:deuce, :hearts),
    Card.new(:three, :spades),
    Card.new(:four,  :clubs),
    Card.new(:five,  :hearts),
    Card.new(:six,   :spades) ] }
  let(:ace_low) { [ Card.new(:deuce, :hearts),
    Card.new(:three, :spades),
    Card.new(:four,  :clubs),
    Card.new(:five,  :hearts),
    Card.new(:ace,   :spades) ] }
  let(:flush) { [ Card.new(:three, :hearts),
    Card.new(:eight, :hearts),
    Card.new(:four,  :hearts),
    Card.new(:five,  :hearts),
    Card.new(:ace,   :hearts) ] }
  let(:two_pairs) { [ Card.new(:three, :hearts),
    Card.new(:three, :spades),
    Card.new(:four,  :clubs),
    Card.new(:four,  :hearts),
    Card.new(:ace,   :spades) ] }
  let(:fours) { [ Card.new(:three, :hearts),
    Card.new(:three, :spades),
    Card.new(:three, :clubs),
    Card.new(:three, :diamonds),
    Card.new(:ace,   :spades) ] }


  describe '::draw_cards' do
    it 'returns a new Hand' do
      expect(Hand.draw_cards(deck)).to be_a(Hand)
    end

    it 'draws 5 cards' do
      expect(hand.cards.count).to be(5)
    end
  end

  describe '#sort' do
    it 'sorts the cards in ascending order' do
      hand.cards = straight.shuffle

      expect(hand.sort).to eq(straight)
    end
  end

  describe "#of_a_kind" do
    it 'returns one value for one pair' do
      hand.cards = full_house

      expect(hand.of_a_kind(2).last.value).to eq(:four)
    end

    it 'returns two values for two pairs' do
      hand.cards = two_pairs

      expect(hand.of_a_kind(2).map(&:value).uniq).to eq([:three, :four])
    end


    it 'returns the value if three of a kind' do
      hand.cards = full_house

      expect(hand.of_a_kind(3).last.value).to eq(:three)
    end

    it 'returns the value if four of a kind' do
      hand.cards = fours

      expect(hand.of_a_kind(4).last.value).to eq(:three)
    end

    it 'returns [] otherwise' do
      hand.cards = straight

      expect(hand.of_a_kind(2)).to eq([])
      expect(hand.of_a_kind(3)).to eq([])
    end
  end

  describe '#full_house?' do
    it 'returns true if a full house' do
      hand.cards = full_house

      expect(hand.full_house?).to be(true)
    end

    it 'returns false if no full house' do
      hand.cards = sorted

      expect(hand.full_house?).to be(false)
    end

  end

  describe '#flush?' do
    it 'returns true if flush' do
      hand.cards = flush

      expect(hand.flush?).to be(true)
    end
  end

  describe '#straight?' do
    it 'returns true if straight' do
      hand.cards = straight

      expect(hand.straight?).to be(true)
    end

    it 'returns true if straight is ace to five' do
      hand.cards = ace_low

      expect(hand.straight?).to be(true)
    end
  end

  describe '#score' do
    # raises mysterious error
    # it 'calls of_a_kind' do
    #   hand.cards = straight
    #   allow(hand).to receive(:of_a_kind).with(2)
    #   hand.score
    # end

    it 'returns an integer' do
      expect(hand.score).to be_an(Integer)
    end
  end


  describe 'in_order' do
    it 'return the hand in order, with highest points value last' do
      hand.cards = sorted.shuffle

      expect(hand.in_order).to eq(sorted)

    end
  end

  describe '#beats?' do
    before do
      hand2.cards = full_house
      hand.cards  = ace_low
    end

    it 'returns true if self wins' do
      expect(hand2.beats?(hand)).to be(true)
    end

    it 'returns false if other' do
      expect(hand.beats?(hand2)).to be(false)
    end

    it 'handles score ties' do
      hand2.cards = straight
      expect(hand2.beats?(hand)).to be(true)
    end
  end
end
