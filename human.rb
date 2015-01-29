require_relative 'board.rb'

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
    begin
      @getting = :piece
      puts "#{@name}, which piece would you like to move?"
      input = gets.chomp

      input = parse_input(input)
    rescue CheckersError => e
      puts "\n #{e.message}"

      retry
    end

    input
  end

  def get_end_pos
    begin
      @getting = :end_pos
      puts "Where would you like to move it?"
      input = parse_input(gets.chomp)
    rescue CheckersError => e
      puts "\n #{e.message}"

      retry
    end

    input
  end

  def parse_input(string)
    pos = string.split(" ")
    pos = pos.map {|pos| pos.split("").map(&:to_i)}

    if pos[0].size < 2
      raise InvalidInputError.new "That's an invalid input!"
    elsif @board.empty?(pos[0]) && @getting != :end_pos
      raise EmptySpaceError.new "You chose any empty space!"
    elsif !@board.empty?(pos[0]) && @board[pos[0]].color != @color
      raise WrongColorError.new "You have to pick your color!"
    end

    return pos[0] if @getting == :piece

    pos
  end

end
