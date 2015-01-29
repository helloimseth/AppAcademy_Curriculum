require_relative 'piece.rb'

class Board
  attr_reader :removed, :board

  def initialize(should_fill = true)
    @board = Array.new(8) {Array.new(8)}
    fill_board if should_fill
    @removed = []
  end

  def [](pos)
    x, y = pos

    board[y][x]
  end

  def []=(pos, value)
    x, y = pos

    board[y][x] = value
  end

  def add_piece(piece)
    self[piece.pos] = piece
  end

  def remove_piece(piece)
    removed << piece
    self[piece.pos] = nil
  end

  def empty?(pos)
    self[pos].nil?
  end

  def dup
    Board.new(false).tap do |board|
      pieces.each {|piece| Piece.new(board, piece.color, piece.pos)}
    end
  end

  private

  def fill_board
    board.each_index do |row|
      add_row(row) unless [3, 4].include?(row)
    end
  end

  def add_row(row_num)
    i = row_num
    shift = 1 - row_num % 2
    color = (row_num < 4) ? :black : :red

    8.times do |j|
      Piece.new(self, color, [i, j + shift]) if j % 2 == 0
    end
  end

  def pieces
    board.flatten.compact
  end

end
