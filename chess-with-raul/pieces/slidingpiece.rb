require_relative 'piece.rb'

class SlidingPiece < Piece

  DIAGONALS = [[-1, 1], [-1, -1], [1, -1], [1, 1]]
  RIGHT_ANGLES = [[0, 1], [0, -1], [-1, 0], [1, 0]]

  def moves

    possible_moves = []

    self.class::DELTAS.each do |x, y|
      possible_moves += build_moves_in_dir(x,y)
    end

    possible_moves.sort
  end

  protected

    def build_moves_in_dir(x,y)
      possible_moves = []
      next_pos = next_pos(x, y)

      until move_off_board?(next_pos) || hit_same_team?(next_pos)
        possible_moves << next_pos

        break unless board.empty?(next_pos)

        next_pos = [(next_pos[0] + x), (next_pos[1] + y)]
      end
      possible_moves
    end

end
