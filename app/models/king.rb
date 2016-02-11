class King < GamePiece

  def valid_move?(new_x, new_y)
    dx = (new_x - x).abs
    dy = (new_y - y).abs
    return true if dx == 1 && dy == 1
    return true if dx == 1 && dy == 0
    return true if dx == 0 && dy == 1
    false
  end

  def icon
    image = "&#9818;"
    return image.html_safe
  end

end
