require_relative 'piece.rb'

class SteppingPiece < Piece

  def moves
    possible_moves = []

    self.class::DELTAS.each do |(x, y)|
      next_pos = next_pos(x, y)

      next if move_off_board?(next_pos) || hit_same_team?(next_pos)

      possible_moves << next_pos
    end

    possible_moves.sort
  end

end
