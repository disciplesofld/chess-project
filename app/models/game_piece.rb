class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def move_to(new_x, new_y)
    self.update_attributes(x: new_x, y: new_y)
  end

  def valid_move?(new_x, new_y)
    # always return false...force subclasses to implement :)
    false
  end

end
