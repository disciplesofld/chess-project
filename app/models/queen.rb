class Queen < GamePiece


  # def move_piece(new_x, new_y)
  #   self.x = self.x
  #   self.y = self.y
  #   n_x = new_x.to_i
  #   n_y = new_y.to_i
  #   if is_move_validated?(self.x, self.y, n_x, n_y)  # true means move is ok.
  #     self.update_attributes(:x => new_x, :y => new_y)
  #   end
  # end - Not needed anymore; STI is now functioning as needed

  def valid_move?(next_x, next_y)
    # Now only needs 2 args, and those need modified to integers - all variables adjusted to reflect
    if is_move_horizontal?(next_x, next_y) \
        || is_move_vertical?(next_x, next_y) \
        || is_move_diagonal?(next_x, next_y)
      #self.move_piece(next_x, next_y)
      return true
    else
      return false
    end
  end

  # def did_it_move?(self.x, self.y, next_x, next_y)
  #   if (self.x == n_x) && (self.y == n_y)
  #     return false
  #   else
  #     return true
  #   end
  # end - Not needed anymore; current location not available as a move

  def is_move_horizontal?(n_x, n_y)
    if (self.x != n_x) && (self.y == n_y)
      return true
    else
      return false
    end
  end

  def is_move_vertical?(n_x, n_y)
    if (self.x == n_x) && (self.y != n_y)
      return true
    else
      return false
    end
  end

  def is_move_diagonal?(n_x, n_y)
    if ((n_x - self.x).abs == (n_y - self.y).abs)
      return true
    else
      return false
    end
  end

  def icon
    image = "&#9819"
    return image.html_safe
  end

end
