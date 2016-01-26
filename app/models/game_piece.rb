class GamePiece < ActiveRecord::Base
  belongs_to :game
  belongs_to :user


  def move_piece(new_x, new_y)
      self.update_attributes(:x => new_x, :y => new_y)
    #SET THIS TO RECEIVE EACH PIECE TYPE BOOLEAN
  end

  def valid_move?(new_x, new_y)
    raise "error"
    # RECEIVES BOOLEAN FROM EACH PIECE TYPE MODEL
  end

end
