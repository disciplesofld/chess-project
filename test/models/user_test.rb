require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'the factory can create a user' do
    user = FactoryGirl.create(:user)
    assert user
  end
end
