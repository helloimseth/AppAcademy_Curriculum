class Piece
  attr_reader :color
  attr_accessor :board, :pos

  def initialize(starting_pos, board, color)
    @pos = starting_pos
    @board = board
    @color = color
  end


  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def render
    return self.class::SYMBOL
  end


  def move_into_check?(end_pos)
    dupped_board = board.dup

    dupped_board.move!(pos, end_pos)

    dupped_board.in_check?(color)
  end

  protected

    def move_off_board?(pos)
      pos.any? { |coord| !coord.between?(0,7) }
    end

    def hit_same_team?(pos)
      !board.empty?(pos) && board[pos].color == color
    end

    def hit_enemy?(pos)
      !board.empty?(pos) && board[pos].color != color
    end

    def next_pos(x, y)
      next_x, next_y  = (pos[0] + x), (pos[1] + y)
      [next_x, next_y]
    end

end
