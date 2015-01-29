# encoding: utf-8

require_relative 'errors.rb'

class Piece
  attr_accessor :pos, :is_king
  attr_reader :color, :board

  SYMBOL = {red: "R", black: "B"}
  UP_DOWN = {red: -1, black: 1}

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @is_king = false

    board.add_piece(self)
  end

  def perform_moves(sequence)
    if valid_move_seq?(sequence)
      perform_moves!(sequence)
    else
      raise InvalidMoveError.new "Sorry, that sequence is invalid."
    end
    nil
  end

  def render
    SYMBOL[color]
  end

  def perform_slide(end_pos)
    return false unless valid_slide?(end_pos)

    board[pos] = nil
    board[end_pos] = self
    self.pos = end_pos

    true
  end

  def perform_jump(end_pos)
    deltas = find_diff(end_pos)

    if end_pos.none? {|coord| coord.between?(0,7)}
      return false
    elsif !jump_diffs.include?(deltas)
      return false
    elsif !board.empty?(end_pos)
      return false
    end

    jumped_pos = [pos[0] + UP_DOWN[color],
                  pos[1] + 3 % deltas[1]]

    return false if board.empty?(jumped_pos) || board[jumped_pos].color == color

    board[pos] = nil
    board[end_pos] = self
    board.remove_piece_from(jumped_pos)
    self.pos = end_pos

    true
  end

  def perform_moves!(sequence)
    is_slide = perform_slide(sequence[0]) if sequence.count == 1

    if !is_slide
      sequence.each do |move|
        unless perform_jump(move)
          raise InvalidMoveError.new "Sorry, that sequence is invalid."
        end
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

  def slide_diffs
     diffs = []

     y_delta = UP_DOWN[color]

     diffs << [y_delta, 1]
     diffs << [y_delta, -1]

     diffs + king_diffs(diffs)
  end

  def jump_diffs
     diffs = slide_diffs.map{|y, x| [y * 2, x * 2]}
  end

  def king_diffs(moves)
    return [] unless is_king

    moves.map{|y, x| [y * -1, x]}
  end

  def find_diff(end_pos)
    deltas = []
    deltas[0] = end_pos[0] - pos[0]
    deltas[1] = end_pos[1] - pos[1]
    deltas
  end

  def valid_slide?(end_pos)
    deltas = find_diff(end_pos)

    if end_pos.none? {|coord| coord.between?(0,7)}
      return false
    elsif !slide_diffs.include?(deltas)
      return false
    elsif !board.empty?(end_pos)
      return false
    end

    true
  end

  def maybe_promote
    is_king = true if color == :black && pos[0] == 7
    is_king = true if color == :red && pos[0] == 0
  end

end
