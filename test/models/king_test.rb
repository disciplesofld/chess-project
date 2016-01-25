require 'test_helper'

# rake test test/models/kg_test.rb
module KG
  class UserTest < ActiveSupport::TestCase
    test 'the factory can create a user' do
      u = FactoryGirl.create(:user)
      assert u
    end
  end

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
      assert g.game_pieces.count == 0
      g.populate_pieces!
      assert g.game_pieces.count == 32
    end
    
  end
end