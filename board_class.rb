require_relative 'piece_class.rb'
require_relative 'game_class.rb'

class Board

  attr_reader :captured, :board

  def initialize
    @board = Array.new(8) {Array.new(8)}
    place_pieces
    @captured = []
  end

  def place_pieces
    [[0,0],[0,7],[7,0],[7,7]].each do |pos|
      if pos[0] == 0
        self[pos] = Rook.new(pos, self, :black)
      else
        self[pos] = Rook.new(pos, self, :white)
      end
    end

    [[0,1],[0,6],[7,1],[7,6]].each do |pos|
      if pos[0] == 0
        self[pos] = Knight.new(pos, self, :black)
      else
        self[pos] = Knight.new(pos, self, :white)
      end
    end

    [[0,2],[0,5],[7,2],[7,5]].each do |pos|
      if pos[0] == 0
        self[pos] = Bishop.new(pos, self, :black)
      else
        self[pos] = Bishop.new(pos, self, :white)
      end
    end

    [[0,3],[7,4]].each do |pos|
      if pos[0] == 0
        self[pos] = Queen.new(pos, self, :black)
      else
        self[pos] = Queen.new(pos, self, :white)
      end
    end

    [[0,4],[7,3]].each do |pos|
      if pos[0] == 0
        self[pos] = King.new(pos, self, :black)
      else
        self[pos] = King.new(pos, self, :white)
      end
    end

    [1,6].each do |row|
      @board[row].each_index do |col|
        pos = [row,col]
        if pos[0] == 1
          self[pos] = Pawn.new(pos, self, :black)
        else
          self[pos] = Pawn.new(pos, self, :white)
        end
      end
    end

  end


  def in_check?(color)
    king_position = king_position(color)
    in_check = false

    each_pos do |pos|
      if !self[pos].nil? && self[pos].color != color
        in_check = true if self[pos].moves.include?(king_position)
      end
    end

    in_check
  end



  def check_mate?(color)
    # if in_check? == true, this will check if the Kings#valid_moves.count == 0
    # the hard part is it also needs to see if any of its color can block the
    # attacker. This will require a helper method returns an array of the
    # squares that could be used to block and then query if any of the
    # same-colored pieces have one of those squares in their valid_moves
  end

  def move(start_pos, end_pos)
    raise "You chose an empty square!" if self[start_pos].nil?
    unless self[start_pos].moves.include?(end_pos)
      raise "That piece can't move like that!"
    end

    captured << self[end_pos] if !self[end_pos].nil?

    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def dup
    #deep_dup of the board
  end

  def render
    # creates visual representation. i don't know if you saw Joe and my
    # minesweeper but it was hot. i got some tricks up my sleeve
  end

  def display
    print render
  end

  # Below are convenience methods

  def [](pos)
    y, x = pos


    board[y][x]
    # method to make calling positions easier. acts as attr_reader
  end

  def []=(pos, value)
    # method to make assigning positions easier
    y, x = pos

    board[y][x] = value

  end

  def each_pos(&prc)
    # joe and i made this for minesweeper - was SO useful for the many times we had to do nested loops to access a square the the @board

    board.each do |row|
      row.each do |col|
        prc.call([row, col])
      end
    end

  end

  private

    def king_position(color)
      king_pos = nil

      each_pos do |pos|
        if self[pos].class == King && self[pos].color == color
          king_pos = pos
        end
      end

      king_pos
    end

end
