require 'test_helper'
require 'pry'
# rake test test/models/kg_test.rb
module KG
  class GameTest < ActiveSupport::TestCase
    test 'the factory can create a game' do
      g = FactoryGirl.create(:game)
      assert g

      w = FactoryGirl.create(:user, email: 'wunderbar@underground.org')
      h = FactoryGirl.create(:game, player_white: w)
      assert h
    end

    test 'the game can be populated' do
      g = FactoryGirl.create(:game)
      # game is created with no pieces
      assert g.game_pieces.count == 0
      # populate and check the number of pieces placed
      g.populate_pieces!
      assert g.game_pieces.count == 32
      # make sure all pieces are alive
      g.game_pieces.each do |piece|
        assert piece.alive?
      end
    end
  end
end
