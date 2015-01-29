require_relative 'piece.rb'
require 'colorize'

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
    background = :defaul

    print " " * 4
    puts (0...8).to_a.join(" " * 4).colorize(background)

    board.each_with_index do |row, index|
      background = (background == :white) ? :default : :white
      print "#{index} "

      row.map do |piece|
        background = (background == :white) ? :default : :white
        if piece.nil?
          print (" " * 5).colorize(:background => background)
        else
          print "  #{piece.render}  ".colorize(:background => background)
        end
      end
      puts "\n"
    end

    puts "\n"

  end

  def display
    render
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
