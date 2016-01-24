require 'test_helper'

module KG
  class UserTest < ActiveSupport::TestCase
    test "the factory can create a user" do
      u = FactoryGirl.create(:user)
      p u
      assert u
    end
  end

  class GameTest < ActiveSupport::TestCase
    test "the factory can create a game" do
      g = FactoryGirl.create(:game)
      p g
      assert g

      w = FactoryGirl.create(:user, email: 'wunderbar@underground.org')
      p w
      h = FactoryGirl.create(:game, player_white: w)
      p h
      assert h
    end
  end
end
