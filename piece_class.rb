require_relative 'board_class.rb'
require_relative 'game_class.rb'

class Piece
  attr_reader :pos, :board, :color

  def initialize(starting_pos, board, color)
    @pos = starting_pos
    @board = board
    @color = color
  end

  def moves
    # Would be called in the implented sublcass #moves method using
    # Super. in rethinking this, i'd say that this method would weed out those
    #moves which are off the board's bounds because that doesn't take more logic than a #between? method call
  end

  def valid_moves
    # calls the #moves method. I think it makes sense that it would be called
    # by the subclasses, though because the functionality would be identical for SteppingPieces and SlidingPieces it stays up here.

    # I think the implementation is something like:
    #   - Iterate through the moves array (which is now an array of all
    #    places on the board the piece could move to if there were no
    #    other pieces on the board)
    #   - for each position in the moves array, ask if it's valid via
    #     the is_valid?(pos) helper method below
    #   - if it is, shovel it into a new array that gets return
  end

  protected # => want it to be accessible from subclasses

  def is_valid?(pos)
    # for the receiving position, make a dup of the board using a board dup method we'll create. ask if there's a piece of the same color in that place. If so, return false
    #
    # something to think about: how to we ask for sliding pieces if there are any pieces BETWEEN the start and end positions.
  end


end

class SlidingPiece < Piece

  def moves

    possible_moves = []

    self.class::DELTAS.each do |(x, y)|
      next_x, next_y  = (pos[0] + x), (pos[1] + y)
      next_pos = [next_x, next_y]

      until next_pos.any? { |coord| !coord.between?(0,7) } ||
        (!board[next_pos].nil? && board[next_pos].color == color)

        possible_moves << next_pos

        break unless board[next_pos].nil?

        next_pos = [(next_pos[0] + x), (next_pos[1] + y)]
      end
    end

    possible_moves.sort
  end

end

class Bishop < SlidingPiece

  DELTAS = [[-1, 1], [-1, -1], [1, -1], [1, 1]]

end

class Rook < SlidingPiece

  DELTAS = [[0, 1], [0, -1], [-1, 0], [1, 0]]

end

class Queen < SlidingPiece

  DELTAS = [[0, 1], [0, -1], [-1, 0],
            [1, 0], [-1, 1], [-1 , -1],
            [1, -1], [1, 1]]

end

class SteppingPiece < Piece

  def moves
    possible_moves = []

    self.class::DELTAS.each do |(x, y)|
      next_x, next_y  = (pos[0] + x), (pos[1] + y)
      next_pos = [next_x, next_y]

      if next_pos.all? { |coord| coord.between?(0,7) } ||
        (!board[next_pos].nil? && board[next_pos].color != color)
        possible_moves << [next_x, next_y]
      end
    end

    possible_moves.sort
  end

end

class King < SteppingPiece


    DELTAS = [[0, 1], [0 , -1], [-1, 0], [1, 0], [-1, 1],
    [-1 , -1], [1, -1], [1, 1]]

end

class Knight < SteppingPiece


  DELTAS = [[2, 1], [2 , -1], [-1, 2], [1, 2],
  [-2, 1], [-2 , -1], [-1, -2], [1, -2]]

end

class Pawn < Piece
  attr_reader :first_move

  def initialize(starting_pos, board, color)
    super(starting_pos, board, color)
    @first_move = true # because it has different behavior on first move

  end

  def moves
    possible_moves = []

    if color == :black
      left_diag = [pos[0] + 1, pos[1] - 1]
      right_diag = [pos[0] + 1, pos[1] + 1]
      forward = [pos[0] + 1, pos[1]]
      slide_forward = [pos[0] + 2, pos[1]]
    else
      left_diag = [pos[0] - 1, pos[1] - 1]
      right_diag = [pos[0] - 1, pos[1] + 1]
      forward = [pos[0] - 1, pos[1]]
      slide_forward = [pos[0] - 2, pos[1]]
    end

    if first_move && board[forward].nil? && board[slide_forward].nil?
      possible_moves << slide_forward
    end

    if board[forward].nil?
      possible_moves << forward
    elsif !board[left_diag].nil?
      possible_moves << left_diag
    elsif !board[right_diag].nil?
      possible_moves << right_diag
    end

    possible_moves.sort
  end

end
