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

  def game_over?
    winner_is != nil || no_valid_moves?(:red) || no_valid_moves?(:black)
  end

  def no_valid_moves?(color)
    any_valid_moves = true
    pieces.each do |piece|
      any_valid_moves = false if piece.valid_moves.count > 0
    end
    any_valid_moves
  end

  def display
    puts " " * 20 + "Board"
    puts render
    print "\n\n"
    puts " " * 18 + "Board Codes"
    puts render_locations
  end

  private

  def winner_is
    remaining = pieces - removed
    same_color = true
    test_color = remaining[0].color

    return test_color if remaining.all? {|piece| piece.color == test_color}

    nil
  end

  def fill_board
    board.each_index do |row|
      add_row(row) unless [3, 4].include?(row)
    end
  end

  def render
    background = :default
    board.map.with_index do |row, index|
      background = (background == :white) ? :default : :white
      # print "#{index} "
      row.map do |piece|
        background = (background == :white) ? :default : :white
        if piece.nil?
          (" " * 6).colorize(:background => background)
        else
          "  #{piece.render}  ".colorize(:background => background)
        end
      end.join("")
    end.join("\n")
  end

  def render_locations
    background = :default

    board.map.with_index do |row, row_i|
      background = (background == :white) ? :default : :white
      row.map.with_index do |col, col_i|
        background = (background == :white) ? :default : :white
        if col_i % 2 == row_i % 2
          (" " * 6).colorize(:background => background)
        else
          "  #{row_i}#{col_i}  ".colorize(:background => background)
        end
      end.join("")
    end.join("\n")
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
