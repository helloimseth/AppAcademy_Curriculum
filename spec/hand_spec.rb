require 'hand'
require 'card'

describe Hand do
  let(:deck) { double("deck") }
  before { allow(deck).to receive(:take).with(5).and_return(random_hand) }
  let(:hand) { Hand.draw_cards(deck) }
  let(:random_hand) { Array.new(5) { Card.new(nil, nil, true) } }
  let(:sorted) { [ Card.new(:three, :hearts),
    Card.new(:three, :spades),
    Card.new(:four,  :clubs),
    Card.new(:five,  :hearts),
    Card.new(:ace,   :spades) ] }
  let(:full_house) { [ Card.new(:three, :hearts),
    Card.new(:three, :spades),
    Card.new(:three,  :clubs),
    Card.new(:four,  :hearts),
    Card.new(:four,   :spades) ] }

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
      hand.cards = sorted.shuffle

      expect(hand.sort).to eq(sorted)
    end
  end

  describe "#of_a_kind" do



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

    it 'returns one value for one pair' do
      hand.cards = full_house

      expect(hand.of_a_kind(2)).to eq([:four])
    end

    it 'returns two values for two pairs' do
      hand.cards = two_pairs

      expect(hand.of_a_kind(2)).to eq([:three, :four])
    end


    it 'returns the value if three of a kind' do
      hand.cards = full_house

      expect(hand.of_a_kind(3)).to eq([:three])
    end

    it 'returns the value if four of a kind' do
      hand.cards = fours

      expect(hand.of_a_kind(4)).to eq([:three])
    end
  end

  describe '#full_house' do
    it 'returns a values of full house' do
      hand.cards = full_house

      expect(hand.full_house).to eq([:four, :three])
    end

    it 'returns an empty array if no full house' do
      hand.cards = sorted

      expect(hand.full_house).to eq([])
    end

  end

  describe '#flush?' do
    let(:flush) { [ Card.new(:three, :hearts),
      Card.new(:eight, :hearts),
      Card.new(:four,  :hearts),
      Card.new(:five,  :hearts),
      Card.new(:ace,   :hearts) ] }

    it 'returns true if flush' do
      hand.cards = flush

      expect(hand.flush?).to be(true)
    end
  end

  describe '#straight?' do
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

    it 'returns true if straight' do
      hand.cards = straight

      expect(hand.straight?).to be(true)
    end

    it 'returns true if straight is ace to five' do
      hand.cards = ace_low

      expect(hand.straight?).to be(true)
    end
  end





end
