class Queen < GamePiece



  def is_move_validated?(current_x, current_y, next_x, next_y)
    if is_move_horizontal?(current_x, current_y, next_x, next_y) \
        || is_move_vertical?(current_x, current_y, next_x, next_y) \
        || is_move_diagonal?(current_x, current_y, next_x, next_y)
      return true
    else
      return false
    end
  end

  def did_it_move?(current_x, current_y, next_x, next_y)
    if (current_x == next_x) && (current_y == next_y)
      return false
    else
      return true
    end
  end

  def is_move_horizontal?(current_x, current_y, next_x, next_y)
    if (current_x != next_x) && (current_y == next_y)
      return true
    else
      return false
    end
  end

  def is_move_vertical?(current_x, current_y, next_x, next_y)
    if (current_x == next_x) && (current_y != next_y)
      return true
    else
      return false
    end
  end

  def is_move_diagonal?(current_x, current_y, next_x, next_y)
    if ((next_x - current_x).abs == (next_y - current_y).abs)
      return true
    else
      return false
    end
  end


end
