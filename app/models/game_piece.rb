class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def move_piece(new_x, new_y)
    self.update_attributes(:x => new_x, :y => new_y)
  end

end
