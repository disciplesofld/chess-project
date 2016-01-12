require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user can start game" do
    started_game = FactoryGirl.create(:game)
    assert started_game.save  # persisted?
  end

  test "second user can view game to join" do
    started_game = FactoryGirl.create(:game)
    Game.where(player_white_id: 0).find_each do |game|
      return joinable_game = game
    end
    assert_not_nil joinable_game
  end

  # test "second user can join game" do
  #   started_game = Game.create(id: 1, player_black_id: 1, name_for_game: "royalty bout")
  #
  # end

end
