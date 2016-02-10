class Pawn < GamePiece
  def valid_move?(new_x, new_y)
    # determine if pawn is moving ahead or diagonal to take opponent piece
    # self.x = Column index; self.y = Row index (reversed: bottom-to-top)

    if self.x == new_x
      self.vert_move(new_x, new_y)
    else
      self.diagonal_taking_move(new_x, new_y)
    end
  end

  # Based on no. of moves, 1 or 2 blocks forward, only
  def vert_move(new_x, new_y)
    if pawn_white?
      (self.moved >= 1 && new_y == (self.y + 1)) || \
        (self.moved == 0 && new_y <= (self.y + 2))
    else # Black pawn
      (self.moved >= 1 && (self.y - 1) == new_y) || \
        (self.moved == 0 && (self.y - 2) <= new_y)
    end
  end

  def diagonal_taking_move(new_x, new_y)
    # Logic to allow for single diagonal move to take opponent piece
    if ([self.x - 1, self.x + 1].include?(new_x)) && (can_diagonal_capture(new_x, new_y) || can_passant_capture)
      (pawn_white? && new_y == self.y + 1) || new_y == self.y - 1
    end
  end

  def can_diagonal_capture(new_x, new_y)
    # Find if opponent in new vertices
    foe_id = self.game.get_enemy_of(self.user_id) # Returns player_id of opponent
    self.game.game_pieces.where("x = ? AND y = ? AND user_id = ?", new_x, new_y, foe_id).first
  end

  def can_passant_capture
    last_piece = self.game.game_pieces.order(:updated_at).last
    # Check if last move was opponent's pawn, piece's first move, moved 2 spaces & sits next to self
    last_piece.type == "Pawn" && last_piece.user_id != self.user_id && last_piece.moved == 1 && en_passant_row == last_piece.y && ([self.x + 1, self.x - 1].include? last_piece.x)
    # Can move diagonally & take opponent's pawn
  end

  def en_passant_row
      # only if self is on row 4 or 3....
      if [3, 4].include? self.y
        # Return value of only 2 possible rows, depending on game_piece team
        return pawn_white? ? 4 : 3
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
