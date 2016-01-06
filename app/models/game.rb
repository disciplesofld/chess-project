class Game < ActiveRecord::Base
  has_many :game_pieces
  belongs_to :player_white, :class_name => "User", :foreign_key :player_white_id
  belongs_to :player_black, :class_name => "User", :foreign_key :player_black_id
end
