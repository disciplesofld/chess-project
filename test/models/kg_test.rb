require 'test_helper'

# rake test test/models/kg_test.rb
module KG
  class UserTest < ActiveSupport::TestCase
    test "the factory can create a user" do
      u = FactoryGirl.create(:user)
      #p u
      assert u
    end
  end

  class GameTest < ActiveSupport::TestCase
    test "the factory can create a game" do
      g = FactoryGirl.create(:game)
      #p g
      assert g

      w = FactoryGirl.create(:user, email: 'wunderbar@underground.org')
      #p w
      h = FactoryGirl.create(:game, player_white: w)
      #p h
      assert h
    end
    
    test "create game populate pieces" do
      w = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      p w
      b = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      p b
      h = FactoryGirl.create(:game, player_white: w, player_black: b)
      p h
      assert h
      
      white_king = FactoryGirl.create(:game_piece, x: 5, y: 5, type: 'King', status: 1, user_id: w, game_id: h)
      p white_king
      assert white_king.is_piece_alive?
    end
  end
end
