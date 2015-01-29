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

    board[x][y]
  end

  def []=(pos, value)
    x, y = pos

    board[x][y] = value
  end

  def add_piece(piece)
    self[piece.pos] = piece
  end

  def remove_piece_from(pos)
    removed << self[pos].dup
    self[pos] = nil
  end

  def empty?(pos)
    self[pos].nil?
  end

  def dup
    Board.new(false).tap do |board|
      pieces.each {|piece| Piece.new(board, piece.color, piece.pos)}
    end
  end

  def render
    rendered_rows = []

    board.each_with_index do |row, index|
      rendered_row = [index]
      rendered_row << "|"
      rendered_row << row.map{ |piece| piece.nil? ? " " : piece.render}
      rendered_rows << rendered_row.join(" ")
    end

    rendered_rows << [" " * 3].concat(Array.new(8, "-")).join(" ")
    rendered_rows << [" " * 3].concat((0...8).to_a).join(" ")

    rendered_rows
  end

  def display
    render.each { |line| puts line }
    nil
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
