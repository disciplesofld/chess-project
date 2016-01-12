class Game < ActiveRecord::Base
  has_many :game_pieces
  belongs_to :player_white, :class_name => "User", :foreign_key => "player_white_id"
  belongs_to :player_black, :class_name => "User", :foreign_key => "player_black_id"

  def joinable_game
    q = self.where(player_white_id: nil).where.not(player_black_id: current_user.id)
    if q != nil
      q.find_each do |game|
        game
      end
    else
      response = "No available opponents, currently."
    end
  end

end
