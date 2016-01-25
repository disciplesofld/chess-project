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

    test 'is_obstructed vertical' do
      game = FactoryGirl.create(:game)
      wid = game.player_white.id

      wr = Rook.new(user_id: wid, x: 0, y: 0)
      game.add_piece(wr)
      wp = Pawn.new(user_id: wid, x: 0, y: 2)
      game.add_piece(wp)

      obs = game.is_obstructed_new?(wr, 0, 6)
      assert obs
    end

    test 'is_obstructed horizontal (at destination)' do
      game = FactoryGirl.create(:game)
      wid = game.player_white.id

      wr = Rook.new(user_id: wid, x: 0, y: 0)
      game.add_piece(wr)
      wp = Knight.new(user_id: wid, x: 6, y: 0)
      game.add_piece(wp)

      obs = game.is_obstructed_new?(wr, 6, 0)
      assert obs
    end

    test 'is_obstructed diagonal' do
      game = FactoryGirl.create(:game)
      wid = game.player_white.id

      wr = Bishop.new(user_id: wid, x: 2, y: 0)
      game.add_piece(wr)
      wp = Pawn.new(user_id: wid, x: 3, y: 1)
      game.add_piece(wp)

      obs = game.is_obstructed_new?(wr, 5, 3)
      assert obs
    end
  end
end
