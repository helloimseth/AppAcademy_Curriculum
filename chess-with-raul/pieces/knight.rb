require_relative 'steppingpiece.rb'

class Knight < SteppingPiece

  DELTAS = [[2, 1], [2 , -1], [-1, 2], [1, 2],
  [-2, 1], [-2 , -1], [-1, -2], [1, -2]]
  SYMBOL = "N"

end
