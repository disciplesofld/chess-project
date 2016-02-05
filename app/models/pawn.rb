class Pawn < GamePiece
  def valid_move?(new_x, new_y)
    # determine if pawn is moving ahead or diagonal to take opponent piece - use capture method
    # determine if 1st or 2nd move
    # Based on move, 1 or 2 blocks only forward
    # self.x = Column index; self.y = Row index (reversed: bottom-to-top)
    # NEED TO CHANGE MOVE TO TRUE!!! (in game_piece model)

    if self.x == new_x
      self.vert_move(new_x, new_y)
    else
      self.diagonal_taking_move(new_x, new_y)
    end
  end

  def vert_move(new_x, new_y)
    if pawn_white?
      (self.moved == true && new_y == (self.y + 1)) || \
        (self.moved == false && new_y <= (self.y + 2))
    else # Black pawn
      (self.moved == true && (self.y - 1) == new_y) || \
        (self.moved == false && (self.y - 2) <= new_y)
    end
  end

  def diagonal_taking_move(new_x, new_y)
    # Logic for single diagonal move to take opponent piece - ADD SELF.MOVED HERE!!!!
    if (new_x == self.x - 1 || new_x == self.x + 1) && piece_to_capture(new_x, new_y)
      (pawn_white? && new_y == self.y + 1) || new_y == self.y - 1
    end
  end

  def piece_to_capture(new_x, new_y)
    # Find if opponent in new vertices
    foe_id = self.game.get_enemy_of(self.user_id) # Returns player_id of opponent
    self.game.game_pieces.where("x = ? AND y = ? AND user_id = ?", new_x, new_y, foe_id).first
  end

  def pawn_white? # Determine pawn team
    self.user_id == game.player_white_id
  end

  def icon
    image = "&#9823;"
    return image.html_safe
  end

end
