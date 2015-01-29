require_relative 'board.rb'
require_relative 'human.rb'

class Game
  attr_reader :board, :red_p, :black_p, :turn

  def initialize
    @board = Board.new
    @red_p = Human.new(:red, @board)
    @black_p = Human.new(:black, @board)
    @turn = @red_p
  end

  def play

    loop do
      board.display

      to_move = @turn.get_piece
      p to_move
      to_position = @turn.get_end_pos
      p to_position

      @board[to_move].perform_moves([to_position])

      @turn = @turn == @red_p ? @black_p : @red_p
    end

  end



end
