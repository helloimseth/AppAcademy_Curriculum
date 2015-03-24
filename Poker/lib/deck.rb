require_relative 'card.rb'

class Deck
  attr_accessor :cards

  def self.build_deck
    values = Card::VALUE_STRINGS.keys
    suits = Card::SUIT_STRINGS.keys

    deck = []

    values.each do |value|
      suits.each do |suit|
        deck << Card.new(value, suit)
      end
    end

    deck
  end

  def initialize
    @cards = Deck.build_deck
    shuffle!
  end

  def take(n)
    dealt = []

    n.times { dealt << cards.shift }

    dealt
  end

  def take_back(test_cards)
    if !test_cards.is_a?(Array) || test_cards.any? { |card| !card.is_a?(Card) }
      raise ArgumentError.new
    end

    self.cards += test_cards
  end

  def shuffle!
    self.cards.shuffle!
  end

  def count
    cards.count
  end

end
