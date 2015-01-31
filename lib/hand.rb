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
    return 7 if full_house?
    return 3 if of_a_kind(2).count == 4
    return 2 if of_a_kind(2).count == 2
    return 4 if of_a_kind(3).any?
    return 8 if of_a_kind(4).any?
    return 9 if straight_flush?
    return 6 if flush?
    return 5.5 if straight?
    return 5 if ace_low?
    1
  end

  def of_a_kind(n)
    self.cards.select do |card|

      frequency_map[card.value] == n

    end.sort
  end

  def full_house?
    of_a_kind(2).size == 2 && of_a_kind(3).size == 3
  end

  def flush?
    suit_frequency_map.has_value?(5)
  end

  def ace_low?
    self.sort.map(&:value) == [:deuce, :three, :four, :five, :ace ]
  end

  def straight?
    return true if ace_low?
    cards_in_order?(self.sort)
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
    when -1
      true
    when 1
      false
    end
  end

  def in_order
    if score == 7
      of_a_kind(2) + of_a_kind(3)
    elsif score.between?(2, 3)
      int_score = score.to_i

      remaining_cards = cards - of_a_kind(int_score)
      remaining_cards.sort + of_a_kind(int_score)
    elsif score == 8
      remaining_cards = cards - of_a_kind(4)
      remaining_cards.sort + of_a_kind(4)
    else
      self.sort
    end
  end

  private

  def of_a_kind_tie(other_hand)
    self_pair = of_a_kind(2).map {|value| Card::CARD_VALUES[value]}.sort
    other_pair = other_hand.of_a_kind(2).map {|value| Card::CARD_VALUES[value]}.sort
  end

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
