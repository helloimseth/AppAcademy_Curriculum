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
      next_x, next_y  = (@pos[0] + x), (@pos[1] + y)
      next_pos = [next_x, next_y]


      until next_pos.any? { |coord| !coord.between?(0,7) } ||
        (!@board[next_pos].nil? && @board[next_pos].color == @color)

        possible_moves << next_pos

        next_pos = [(next_pos[0] + x), (next_pos[1] + y)]
      end


    end

    possible_moves
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
    # does a similar thing except this can just fill with an each loop #
    # over the sublcasses #move_ can be smaller because each
    # can only take one step.
    possible_moves = []

    self.class::DELTAS.each do |(x, y)|
      next_x, next_y  = (@pos[0] + x), (@pos[1] + y)
      next_pos = [next_x, next_y]

      if next_pos.all? { |coord| coord.between?(0,7) }
        possible_moves << [next_x, next_y]
      end
    end

    possible_moves
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

  # def initialize
  #   @first_move = false # because it has different behavior on first move
  # end

  def move
    # i realized if we do this implementation, pawn would be its
    # own subclass, which makes sense because they're generally
    # they're own thing. so it can have its own move method
    #
    # if @first_move == false, deltas can be:
    # [[0, 2], [0, 1]]
    # if can capture
    # can move diagonally if it has opportunity to capture
    # else
    # [[0,1]] => I still nested the array in another array
    # the moves method is going treat the result of every move_dirs
    # as an array of arrays
  end

end
