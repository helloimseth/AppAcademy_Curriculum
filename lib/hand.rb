class Hand

  attr_accessor :cards

  def self.draw_cards(deck)
    Hand.new(deck.take(5))
  end

  def initialize(cards)
    @cards = cards
  end

  def sort
    self.dup.cards.sort!
  end

end
