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
    
    test "piece alive and move piece" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      p white
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      p black
      h = FactoryGirl.create(:game, player_white: white)
      p h
      assert h
      
      white_king = FactoryGirl.create(:king, x: 0, y: 4, type: 'King', status: 1, user: white, game: h)
      p white_king
      assert_equal( 1,  white_king.is_piece_alive?)
      
      #test move_piece
      white_king.move_to(5,5)
      p white_king
      assert white_king.x == 5
    end
    
    test "is valid move and Rook check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      black_rook = FactoryGirl.create(:rook, x: 0, y: 4, type: 'Rook', status: 1, user: black, game: h)
      p black_rook
      
      #King move is_valid
      actual = white_king.valid_move_new?(4,4)
      assert_equal(true, actual)
      
      # King cannot be moved if there is a rook in horizontal left from the destination cell
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end
    
    test "Opponent Queen check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      black_queen = FactoryGirl.create(:queen, x: 4, y: 5, type: 'Queen', status: 1, user: black, game: h)
      p black_queen
      
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end
    
    test "Opponent Bishop check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      
      black_bishop = FactoryGirl.create(:bishop, x: 7, y: 1, type: 'Bishop', status: 1, user: black, game: h)
      p black_bishop
      
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end
    
    test "Opponent Pawn check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      
      black_pawn = FactoryGirl.create(:pawn, x: 3, y: 5, type: 'Pawn', status: 1, user: black, game: h)
      p black_pawn
      
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end
    
    test "Opponent King check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      
      black_king = FactoryGirl.create(:king, x: 4, y: 5, type: 'King', status: 1, user: black, game: h)
      p black_king
      
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end
    
     test "Opponent Knight check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      black_kinght = FactoryGirl.create(:knight, x: 5, y: 2, type: 'Knight', status: 1, user: black, game: h)
      p black_kinght
      
      actual = white_king.is_danger?(4,4)
      assert_equal(true, actual)
    end

    test "Opponent Knight not check to king" do
      white = FactoryGirl.create(:user, email: 'isairasigai@yahoo.com')
      black = FactoryGirl.create(:user, email: 'uma_senthil@yahoo.com')
      h = FactoryGirl.create(:game, player_white: white)
      
      white_king = FactoryGirl.create(:king, x: 3, y: 4, type: 'King', status: 1, user: white, game: h)
      black_kinght = FactoryGirl.create(:knight, x: 5, y: 5, type: 'Knight', status: 1, user: black, game: h)
      p black_kinght
      
      actual = white_king.is_danger?(4,4)
      assert_equal(false, actual)
    end
  end
end