require_relative 'errors.rb'

class Piece
  attr_accessor :pos, :king
  attr_reader :color,:board

  UP_DOWN = {red: -1, black: 1}

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @king = false

    board.add_piece(self)
  end

  def perform_slide(end_pos)

    unless valid_slide?(end_pos)
      return false
    end

    board[pos] = nil
    board[end_pos] = self
    self.pos = end_pos

    true
  end

  def perform_jump(end_pos)

    deltas = []
    deltas[0] = end_pos[0] - pos[0]
    deltas[1] = end_pos[1] - pos[1]

    if end_pos.none? {|coord| coord.between?(0,7)}
      return false
    elsif !jump_diffs.include?(deltas)
      return false
    elsif !board.empty?(end_pos)
      return false
    end

    jumped_pos = [pos[0] + UP_DOWN[color],
                  pos[1] + 3 % deltas[1]]

    if board.empty?(jumped_pos)
      return false
    end

    board[pos] = nil
    board[end_pos] = self
    board.remove_piece(board[jumped_pos])
    pos = next_pos

    true
  end

  def perform_moves!(sequence)
    is_slide = perform_slide(sequence[0]) if sequence.count == 1

    is_jump = !is_slide

    while is_jump
      is_jump = perform_jump(sequence.shift)

      break if sequence.empty?

      if is_jump == false
        raise InvalidMoveError.new "Sorry, that sequence is invalid."
      end
    end
  end

  def valid_move_seq?(sequence)
    dup_board = board.dup

    begin
      dup_board[pos].perform_moves!(sequence)
    rescue
      false
    else
      true
    end
  end

  private

  def slide_diffs
     diffs = []

     y_delta = UP_DOWN[color]

     diffs << [y_delta, 1]
     diffs << [y_delta, -1]
  end

  def jump_diffs
     diffs = []

     y_delta = UP_DOWN[color] * 2

     diffs << [y_delta, 2]
     diffs << [y_delta, -2]
  end

  def valid_slide?(end_pos)
    deltas = []
    deltas[0] = end_pos[0] - pos[0]
    deltas[1] = end_pos[1] - pos[1]

    if end_pos.none? {|coord| coord.between?(0,7)}
      return false
    elsif !slide_diffs.include?(deltas)
      return false
    elsif !board.empty?(end_pos)
      return false
    end

    true
  end

  def checking_moves
    return [] unless @king
    #adds moves that are only possible for kings
  end

  def promote_if(row)
    #promote if it's in the correct row based on it's color
  end
end
