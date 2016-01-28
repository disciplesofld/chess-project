class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user


  def move_piece(new_x, new_y)
    #define the piece on new position
    friend_or_enemy = self.game.game_pieces.where(:x => new_x, :y => new_y).first

    #if new posistion is an enemy, capture it
    if friend_or_enemy.present? && self.user_id != friend_or_enemy.user_id
      friend_or_enemy.update_attributes(:x => nil, :y => nil, :status => 0)
      if is_move_validated?(new_x, new_y)
        self.update_attributes(:x => new_x, :y => new_y)
      end
    #if it's a friend piece, return false
    elsif friend_or_enemy.present? && self.user_id == friend_or_enemy.user_id
      return false
    else
      if is_move_validated?(new_x, new_y)
        self.update_attributes(:x => new_x, :y => new_y)
      end
    end
    return true
  end

  def valid_move?(new_x, new_y)
    raise "error"
    # RECEIVES BOOLEAN FROM EACH PIECE TYPE MODEL
  end

end
