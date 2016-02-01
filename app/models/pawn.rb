class Pawn < GamePiece
  def valid_move?(new_x, new_y)
    # determine if pawn is moving ahead or diagonal to take opponent piece - use capture method
    # determine if 1st or 2nd move
    # Based on move, 1 or 2 blocks only forward
    # self.x = Column index; self.y = Row index (reversed: bottom-to-top)

    if self.x == new_x

      if self.user_id == game.player_white_id # White pawn
        if (moved == true && new_y == (self.y + 1)) || \
          (moved == false && new_y <= (self.y + 2))
          return true
        end
      else # Black pawn
        if (moved == true && new_y == (self.y - 1)) || \
          (moved == false && new_y <= (self.y - 2))
          return true
        end
      end

    end

  end

  def icon
    image = "&#9823;"
    return image.html_safe
  end

end
