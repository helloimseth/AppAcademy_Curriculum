
  check_pos1 = [new_y, pos[1] + DIRECTION[color]]
  check_pos2 = [new_y, pos[1] - DIRECTION[color]]

  if board.empty?(check_pos1)
    possible_moves << check_pos1
  else
    next_y = pos[0] + DIRECTION[color] * 2
    next_x = pos[1] + DIRECTION[color] * 2
    next_check = [next_y, next_x]
    possible_moves =
  end
  possible_moves << check_pos2 if board.empty?(check_pos2)
