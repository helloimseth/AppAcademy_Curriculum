require_relative 'steppingpiece.rb'

class King < SteppingPiece

    DELTAS = [[0, 1], [0 , -1], [-1, 0], [1, 0], [-1, 1],
    [-1 , -1], [1, -1], [1, 1]]
    SYMBOL = "K"

end
