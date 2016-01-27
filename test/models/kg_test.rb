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
      p w
      h = FactoryGirl.create(:game, player_white: w)
      p h
      assert h
    end
    
    test "create game populate pieces" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      p white
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      p black
      h = FactoryGirl.create(:game, player_white: white)
      p h
      assert h
      
      white_king = FactoryGirl.create(:king, x: 0, y: 4, type: 'King', status: 1, user: white, game: h)
      p white_king
      assert white_king.is_piece_alive?
      
      white_king.move_piece(5,5)
      p white_king
      assert white_king.x == 5
      
      black_rook = FactoryGirl.create(:rook, x: 0, y: 4, type: 'Rook', status: 1, user: black, game: h)
      p black_rook
      assert white_king.is_valid_rule?(4,4)
      
    end
    
  end
end
