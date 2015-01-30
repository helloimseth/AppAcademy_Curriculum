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

  def of_a_kind(n)
    frequency_map.select { |key, val| val == n }.keys
  end

  private

  def frequency_map
    frequencies = Hash.new {|h, k| h[k] = 0}

    cards.each do |card|
      frequencies[card.value] += 1
    end

    frequencies
  end
end
