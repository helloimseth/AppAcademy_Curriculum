require_relative 'board.rb'
require_relative 'human.rb'
require_relative 'errors.rb'
require 'terminfo'
require 'colorize'

class Game
  attr_reader :board, :red_p, :black_p, :turn

  def initialize
    @board = Board.new
    @red_p = Human.new(:red, @board)
    @black_p = Human.new(:black, @board)
    @turn = @red_p
    play
  end

  def play
    until @board.game_over?
      display

      begin
        to_move = @turn.get_input
        to_position = @turn.get_input
        
        @board[to_move].perform_moves(to_position)
      rescue InvalidMoveError => e
        puts e.message
        retry
      end

      @turn = @turn == @red_p ? @black_p : @red_p
    end
  end

  private

  def display
    puts "\e[H\e[2J"
    puts "     ---*~*~*~*~ Checkers ~*~*~*~*---"
    puts "    Please enter coordinates using the"
    puts "    numbers around the board, with the"
    puts "   vertical index first, e.g. 70 for the"
    puts "          bottom-left-most piece"
    2.times { puts "" }

    board.display
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
end
