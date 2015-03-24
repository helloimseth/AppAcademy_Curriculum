require_relative 'board.rb'

class Computer

  def initialize(color, board)
    @color = color
    @board = board
    @getting = :piece
    @picked_piece
  end

  def get_input
    if @getting == :piece
      pick_piece_to_move
      input = @picked_piece.pos
      @getting = :end_pos
    else
      input = [pick_place_to_move]
      @getting = :piece
    end

    input
  end

  private

  def pick_place_to_move
    @picked_piece.valid_moves.sample
  end

  def pick_piece_to_move
    my_team = @board.pieces.select{ |piece| piece.color == @color }

    my_team.delete_if{ |piece| piece.valid_moves.count == 0 }

    @picked_piece = my_team.sample
  end
end
