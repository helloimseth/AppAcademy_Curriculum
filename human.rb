class Human

  def initialize(color, board)
    @color = color
    @name = get_name
    @board = board
  end

  def get_name
    puts "Hello, #{@color.to_s.capitalize}-Player! What's your name?"
    gets.chomp
  end

  def get_piece
    puts "#{@name}, which piece would you like to move?"
    input = gets.chomp
    parse_input(input)
  end

  def get_end_pos
    input = gets.chomp
    parse_input(input)
  end

  def parse_input(string)
    pos = string.split("")
    pos.map(&:to_i)
  end

end
