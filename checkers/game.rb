require_relative 'board.rb'
require_relative 'human.rb'
require_relative 'computer.rb'
require_relative 'errors.rb'
require 'terminfo'
require 'colorize'

class Game
  attr_reader :board, :red_p, :black_p, :turn

  def initialize
    @board = Board.new
    @red_p = Computer.new(:red, @board)
    @black_p = Computer.new(:black, @board)
    @turn = @red_p
    play
  end

  def play
    until @board.game_over?
      display

      begin
        to_move = @turn.get_input
        p to_move
        to_position = @turn.get_input
        p to_position


        @board[to_move].perform_moves(to_position)
      rescue InvalidMoveError => e
        puts e.message
        retry
      end

      @turn = (@turn == @red_p) ? @black_p : @red_p
    end
  end

  private

  def display
    puts "\e[H\e[2J"
    puts "     ---*~*~*~*~ Checkers ~*~*~*~*---".center(TermInfo.screen_size[1])
    puts "    Please enter coordinates using the".center(TermInfo.screen_size[1])
    puts "    numbers around the board, with the".center(TermInfo.screen_size[1])
    puts "   vertical index first, e.g. 70 for the".center(TermInfo.screen_size[1])
    puts "          bottom-left-most piece".center(TermInfo.screen_size[1])
    2.times { puts "" }

    board.display
  end

end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
end
