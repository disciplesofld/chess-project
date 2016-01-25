class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user

  def move_to(new_x, new_y)
    self.update_attributes(x: new_x, y: new_y)
  end

  # Check the status of the piece and return true if it is alive
  def alive?
    status == 1
  end
end
