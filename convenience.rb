module ConvenienceMethods
  def [](pos)
    y, x = pos

    board[y][x]
  end

  def []=(pos, value)
    y, x = pos

    board[y][x] = value
  end

  def each_teammate(color, &prc)
    each_pos do |pos|
      prc.call(pos) if !empty?(pos) && self[pos].color == color
    end
  end

  def each_enemy(color, &prc)
    each_pos do |pos|
      prc.call(pos) if !empty?(pos) && self[pos].color != color
    end
  end

  def each_pos(&prc)
    board.each_index do |row|
      board[row].each_index do |col|
        prc.call([row, col])
      end
    end
  end

  def empty?(pos)
    y, x = pos

    board[y][x].nil?
  end
end
