class Pawn < GamePiece
  def valid_move?(new_x, new_y)
    # TODO: Implement!
    true # ONLY UNTIL I GET TO VALIDATE
  end

  def icon
    image = "&#9823;"
    return image.html_safe
  end

end
