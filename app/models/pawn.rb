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

  def can_diagonal_capture(new_x, new_y)
    # Find if opponent in new vertices
    foe_id = self.game.get_enemy_of(self.user_id) # Returns player_id of opponent
    self.game.game_pieces.where("x = ? AND y = ? AND user_id = ?", new_x, new_y, foe_id).first
  end

  def can_passant_capture
    # PUT THIS IN GAME.RB LOGIC - will track last move
    # MAKE moved into an integer - to track if first single move or first double move
    last_piece = self.game.game_pieces.order(:updated_at).last
    # Check for if last move was opponent's pawn, & its first move & moved 2 spaces & sits next to self
    last_piece.type == "Pawn" && last_piece.user_id != current_user.id && last_piece.moved == 1 && en_passant_row == last_piece.y && (last_piece.x == self.x+1 || last_piece.x == self.x-1)
    # Can move diagonally & take opponent's pawn

    # Then call this "true" from game_piece/game model
  end

  def en_passant_row
      # Return value of only 2 possible rows, depending on game_piece
      return pawn_white? ? 4 : 3
  end

  def diagonal_taking_move(new_x, new_y)
    # Logic to allow for single diagonal move to take opponent piece
    if (new_x == self.x - 1 || new_x == self.x + 1) && (can_diagonal_capture(new_x, new_y) || can_passant_capture)
      (pawn_white? && new_y == self.y + 1) || new_y == self.y - 1
    end
  end

  def pawn_white? # Determine pawn team
    self.user_id == game.player_white_id
  end

  def icon
    image = "&#9823;"
    return image.html_safe
  end

end
