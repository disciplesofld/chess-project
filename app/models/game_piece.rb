class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user


  def move_to(new_x, new_y)
    #define the piece on new posistion
    friend_enemy = self.game.game_pieces.where(:x => new_x, :y => new_y).first

    if friend_enemy.present? && self.user_id != friend_enemy.user_id
      friend_enemy.update_attributes(:x => nil, :y => nil, :status => 0)  
      self.update_attributes(:x => new_x, :y => new_y)
    elsif friend_enemy.present? && self.user_id == friend_enemy.user_id
      return false
    else
      self.update_attributes(:x => new_x, :y => new_y)
    end
    return true
      
  end

  def valid_move?(new_x, new_y)
    # always return false...force subclasses to implement :)
    false
  end

end
