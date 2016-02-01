# require 'test_helper'

# class GamePieceTest < ActiveSupport::TestCase

#   def create_queen_game_piece(x_1, y_1, new_x, new_y)
#     # (x_1, y_1) <- current position
#     # (new_x, new_y) <- the destination location
#     game = FactoryGirl.create(:game)
#     game.game_pieces << Queen.new(x: x_1, y: y_1, type: "Queen", status: 1, game_id: 1, user_id: 1)
#     gamepiece = Queen.first

#     return gamepiece.move_piece(new_x, new_y)
#   end

#   test "Queen can go to horizontal" do
#     assert_equal true, create_queen_game_piece(0,0,5,0)
#   end

#   test "Queen can go to vertical" do
#     assert_equal true, create_queen_game_piece(0,0,0,5)
#   end

#   test "Queen can go to diagonal" do
#     assert_equal true, create_queen_game_piece(0,0,5,5)
#   end

#   test "Queen can not move like knight" do
#     assert_equal nil, create_queen_game_piece(0,0,1,2)
#   end

# end
