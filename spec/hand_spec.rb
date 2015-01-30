require 'hand'
require 'card'

describe Hand do
  let(:deck) { double("deck") }
  before { allow(deck).to receive(:take).with(5).and_return(random_hand) }
  let(:hand) { Hand.draw_cards(deck) }
  let(:random_hand) { Array.new(5) { Card.new(nil, nil, true) } }

  describe '::draw_cards' do

    it 'returns a new Hand' do
      expect(Hand.draw_cards(deck)).to be_a(Hand)
    end

    it 'draws 5 cards' do
      expect(hand.cards.count).to be(5)
    end
  end

  describe '#sort' do
    let(:sorted) { [ Card.new(:three, :hearts),
      Card.new(:three, :spades),
      Card.new(:four,  :hearts),
      Card.new(:five,  :clubs),
      Card.new(:ace,   :spades) ] }

    it 'sorts the cards in ascending order' do
      hand.cards = sorted.shuffle

      expect(hand.sort).to eq(sorted)
    end
  end
end
