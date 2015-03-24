require_relative 'piece.rb'

class Pawn < Piece

  SYMBOL = "P"
  DIRECTION = {:white => -1, :black => 1}

  attr_reader :first_move

  def initialize(starting_pos, board, color)
    super(starting_pos, board, color)
    @first_move = true

  end

  def moves
    (step_forward + side_attack).sort
  end

  private

    def side_attack
      left_diag = [pos[0] + DIRECTION[color], pos[1] - 1]
      right_diag = [pos[0] + DIRECTION[color], pos[1] + 1]

      [].tap do |possible_moves|
        if hit_enemy?(left_diag)
          possible_moves << left_diag
        elsif hit_enemy?(right_diag)
          possible_moves << right_diag
        end
      end
    end

    def step_forward
      forward = [pos[0] + DIRECTION[color], pos[1]]
      slide_forward = [pos[0] + 2 * DIRECTION[color], pos[1]]

      return [] unless board.empty?(forward)

      [].tap do |possible_moves|
        if first_move && board.empty?(slide_forward)
          possible_moves << slide_forward
        end

        possible_moves << forward
      end
    end

end
