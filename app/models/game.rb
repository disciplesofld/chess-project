class Game < ActiveRecord::Base
  has_many :game_pieces
  belongs_to :player_white, :class_name => "User", :foreign_key => "player_white_id"
  belongs_to :player_black, :class_name => "User", :foreign_key => "player_black_id"

  def populate_pieces!
    game_piece_rank = ["Rook", "Knight", "Bishop", "Queen", "King", "Bishop", "Knight", "Rook"]
    (0..7).each do |i|
      game_pieces << (game_piece_rank[i].constantize).new(x: i, y: 0, status: 1, game_id: self.id, user_id: player_white_id)  #player 1
      game_pieces << Pawn.new(x: i, y: 1, status: 1, game_id: self.id, user_id: player_white_id)  #player 1
      game_pieces << (game_piece_rank[i].constantize).new(x: i, y: 7, status: 1, game_id: self.id, user_id: player_black_id)  #player 2
      game_pieces << Pawn.new(x: i, y: 6, status: 1, game_id: self.id, user_id: player_black_id)  #player 2
    end
  end
end
