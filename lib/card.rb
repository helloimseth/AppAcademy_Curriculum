class Card

  SUIT_STRINGS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  SUIT_VALUES = {
    :clubs    => 1,
    :diamonds => 2,
    :hearts   => 3,
    :spades   => 4
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  CARD_VALUES = {
    :deuce => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  attr_reader :value, :suit

  def initialize(value, suit, random = false)
    @value = ( random ) ? random_value : value
    @suit  = ( random ) ? random_suit  : suit
  end

  def random_value
    VALUE_STRINGS.keys.sample
  end

  def random_suit
    SUIT_STRINGS.keys.sample
  end

  def <=>(other_card)
    case CARD_VALUES[self.value] <=> CARD_VALUES[other_card.value]
    when -1
      -1
    when 1
      1
    when 0
      (SUIT_VALUES[self.suit] < SUIT_VALUES[other_card.suit]) ? -1 : 1
    end
  end

end
