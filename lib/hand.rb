require_relative 'card.rb'
require 'byebug'

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

  def score
    return 7 if full_house.any?
    return 3 if of_a_kind(2).count == 2
    return 2 if of_a_kind(2).count == 1
    return 4 if of_a_kind(3).any?
    return 8 if of_a_kind(4).any?
    return 9 if straight_flush?
    return 6 if flush?
    return 5.5 if straight?
    return 5 if ace_low?
    1
  end

  def of_a_kind(n)
    ( frequency_map.select { |key, val| val == n }.keys )
  end

  def full_house
    # debugger
    of_a_kind(2).size == of_a_kind(3).size ? of_a_kind(2) + of_a_kind(3) : []
  end

  def flush?
    suit_frequency_map.has_value?(5)
  end

  def ace_low?
    sorted.map(&:value) == [:deuce, :three, :four, :five, :ace ]
  end

  def straight?
    sorted = sort
    return true if ace_low?
    cards_in_order?(sorted)
  end

  def straight_flush?
    straight? && flush?
  end

  def values
    cards.map(&:value)
  end

  def beats?(other_hand)
    case self.score <=> other_hand.score
    when 0
      tie_breaker(other_hand)
    else

    end
  end

  private

  def tie_breaker(other_hand)
    if self.score == 2
      own_high = Card::CARD_VALUES[self.of_a_kind(2)]
      other_high = Card::CARD_VALUES[other_hand.of_a_kind(2)]
    elsif self.score == 6
      own_high = Card::CARD_VALUES[self.of_a_kind(3)]
      other_high = Card::CARD_VALUES[other_hand.of_a_kind(3)]
      return own_high > other_high
    else
  end

  def cards_in_order?(sorted)
    last_card = Card::CARD_VALUES[sorted.first.value]

    sorted[1..-1].each do |card|
      this_card = Card::CARD_VALUES[card.value]
      return false if this_card - last_card != 1
      last_card = this_card
    end

    true
  end

  def suit_frequency_map
    frequencies = Hash.new {|h, k| h[k] = 0}

    cards.each do |card|
      frequencies[card.suit] += 1
    end

    frequencies
  end

  def frequency_map
    frequencies = Hash.new {|h, k| h[k] = 0}

    cards.each do |card|
      frequencies[card.value] += 1
    end

    frequencies
  end
end
