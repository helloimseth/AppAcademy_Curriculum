require_relative 'piece_class.rb'
require_relative 'board_class.rb'

class Game
  
  def initialize(white_player, black_player, board)
    @white = white_player
    @black = black_player
    @board = Board.new
  end
  
  def play
    #input loop
    
    # until checkmate or input == draw? - one player could propose a draw
    # and the other could approve? that seems super chessy
    
  end

end