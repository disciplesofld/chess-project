require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "user can start game" do
    started_game = FactoryGirl.create(:game)
    assert started_game.save  # persisted?
  end

  # NOTE this test is not really testing whether the second user can join a game.
  #      it is really just checking a (previously) hard-coded condition. (same goes for previous test)
  #      to rewrite it, here is some pseudo-code
  #      1. create a user
  #      2. create a game with only that user as a player
  #      3. create a new user
  #      4. assert that the new user is not already in the game
  #      5. have that user join the game
  #      6. return true is user is in the game
  test "second user can view game to join" do
    started_game = FactoryGirl.create(:game)
    Game.where(player_white_id: 0).find_each do |game|
      return joinable_game = game
    end
    assert_not_nil joinable_game
  end

  def create_game_pieces(x_1, y_1, x_2, y_2, new_x, new_y)
    # (x_1, y_1) <- current position
    # (x_2, y_2) <- another piece position [could be obstructing]
    # (new_x, new_y) <- the destination location
    game = FactoryGirl.create(:game)
    game.game_pieces << Rook.new(x: x_1, y: y_1, type: "Rook", status: 1, game_id: 1, user_id: 1)
    game.game_pieces << Rook.new(x: x_2, y: y_2, type: "Rook", status: 1, game_id: 1, user_id: 1)
    gamepiece = Rook.first
    return game.is_obstructed?(gamepiece, new_x, new_y)
  end

  test "gamepiece is obstructed by same team piece" do
    assert_equal true, create_game_pieces(0,0,0,1,0,1)
  end

  test "gamepiece is not obstructed by same team piece" do
    assert_equal false, create_game_pieces(0,0,0,7,0,2)
  end

  test "gamepiece is obstructed by another player piece" do
    # this should be valid move since capture can happen.  obstructed? should be false
    game = FactoryGirl.create(:game)
    game.game_pieces << Rook.new(x: 0, y: 0, type: "Rook", status: 1, game_id: 1, user_id: 1)
    game.game_pieces << Rook.new(x: 0, y: 1, type: "Rook", status: 1, game_id: 1, user_id: 2)
    gamepiece = Rook.first
    actual = game.is_obstructed?(gamepiece, 0, 1)
    assert_equal false, actual
  end

  test "gamepiece is obstructed when moving to horizontal to right" do
    assert_equal true, create_game_pieces(3,4,5,4,7,4)
  end

  test "gamepiece is obstructed when moving to horizontal to left" do
    assert_equal true, create_game_pieces(3,4,1,4,0,4)
  end

  test "gamepiece is not obstructed when moving to horizontal to right" do
    assert_equal false, create_game_pieces(3,4,0,0,7,4)
  end

  test "gamepiece is not obstructed when moving to horizontal to left" do
    assert_equal false, create_game_pieces(3,4,0,0,0,4)
  end

  test "gamepiece is obstructed when moving to vertical to up" do
    assert_equal true, create_game_pieces(3,4,3,6,3,7)
  end

  test "gamepiece is obstructed when moving to vertical to down" do
    assert_equal true, create_game_pieces(3,4,3,1,3,0)
  end

  test "gamepiece is not obstructed when moving to vertical to up" do
    assert_equal false, create_game_pieces(3,4,0,0,3,7)
  end

  test "gamepiece is not obstructed when moving to veritical to down" do
    assert_equal false, create_game_pieces(3,4,0,0,3,0)
  end

  test "gamepiece is obstructed when moving to diagonal to up right" do
    assert_equal true, create_game_pieces(3,4,5,6,6,7)
  end

  test "gamepiece is obstructed when moving to diagonal to up left" do
    assert_equal true, create_game_pieces(3,4,1,6,0,7)
  end

  test "gamepiece is obstructed when moving to diagonal to down right" do
    assert_equal true, create_game_pieces(3,4,5,2,7,0)
  end

  test "gamepiece is obstructed when moving to diagonal to down left" do
    assert_equal true, create_game_pieces(3,4,1,2,0,1)
  end

  test "gamepiece is not obstructed when moving to diagonal to up right" do
    assert_equal false, create_game_pieces(3,4,0,0,6,7)
  end

  test "gamepiece is not obstructed when moving to diagonal to up left" do
    assert_equal false, create_game_pieces(3,4,0,0,0,7)
  end

  test "gamepiece is not obstructed when moving to diagonal to down right" do
    assert_equal false, create_game_pieces(3,4,0,0,7,0)
  end

  test "gamepiece is not obstructed when moving to diagonal to down left" do
    assert_equal false, create_game_pieces(3,4,0,0,0,1)
  end
  # test "second user can join game" do
  #   started_game = Game.create(id: 1, player_black_id: 1, name_for_game: "royalty bout")
  #
  # end

end
