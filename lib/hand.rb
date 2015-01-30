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

  def of_a_kind(n)
    frequency_map.select { |key, val| val == n }.keys
  end

  def full_house
    (of_a_kind(2).size == of_a_kind(3).size) ? of_a_kind(2) + of_a_kind(3) : []
  end

  def flush?
    suit_frequency_map.has_value?(5)
  end

  def straight?
    sorted = sort
    return true if sorted.map(&:value) == [:deuce, :three, :four, :five, :ace ]

    last_card = Card::CARD_VALUES[sorted.first.value]

    sorted[1..-1].each do |card|
      this_card = Card::CARD_VALUES[card.value]
      return false if this_card - last_card != 1
      last_card = this_card
    end

    true
  end

  def straight_flush?
    straight? && flush?
  end

  private

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
