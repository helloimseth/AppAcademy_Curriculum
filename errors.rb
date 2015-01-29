class CheckersError < StandardError
end

class InvalidMoveError < CheckersError
end

class WrongColorError < CheckersError
end

class EmptySpaceError < CheckersError
end
