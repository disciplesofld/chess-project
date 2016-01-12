require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "redirects to games index" do
    user = FactoryGirl.create(:user)
    sign_in user
    assert_response :success
  end

  test "current games can be viewed?" do
    assert_difference 'Game.count' do
      current_game = FactoryGirl.create(:game)
    end
    assert_equal 1, Game.count
  end

  test "second user can join game" do
    user_id = 2
    started_game = FactoryGirl.create(:game)
    assert_no_difference 'Game.count' do
      put :update, id: started_game.id, game: {player_white_id: user_id}
    end
    # assert_redirected_to place_path(place)
  end

end
