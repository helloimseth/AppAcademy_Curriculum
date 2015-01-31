require_relative 'board.rb'
require 'byebug'

class Human
  REQUESTS = {piece: "which piece would you like to move?",
              end_pos: "where would you like to move it?"}

  def initialize(color, board)
    @color = color
    @name = get_name
    @board = board
    @getting = :piece
  end

  def get_name
    puts "Hello, #{@color.to_s.capitalize}-Player! What's your name?"
    gets.chomp
  end

  def get_input
    # debugger
    begin
      puts "#{@name}, #{REQUESTS[@getting]}"
      input = gets.chomp

      input = parse_input(input)
    rescue CheckersError => e
      puts "\n #{e.message}"

      retry
    end

    @getting == :piece ? @getting = :end_pos : @getting = :piece
    
    input
  end

  # def get_end_pos
  #   begin
  #     @getting = :end_pos
  #     puts "\nWhere would you like to move it?"
  #     input = parse_input(gets.chomp)
  #   rescue CheckersError => e
  #     puts "\n #{e.message}"
  #
  #     retry
  #   end
  #
  #   input
  # end

  def parse_input(string)
    pos = string.split(" ")
    pos = pos.map {|pos| pos.split("").map(&:to_i)}

    validate_input(pos)

    return pos[0] if @getting == :piece

    pos
  end

  def validate_input(pos)
    if pos[0].size < 2
      raise InvalidInputError.new "That's an invalid input!"
    elsif @board.empty?(pos[0]) && @getting != :end_pos
      raise EmptySpaceError.new "You chose any empty space!"
    elsif !@board.empty?(pos[0]) && @board[pos[0]].color != @color
      raise WrongColorError.new "You have to pick your color!"
    end
  end

end
