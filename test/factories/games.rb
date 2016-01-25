FactoryGirl.define do

  sequence :name_for_game do |n|
    "game#{n}"
  end

  sequence :id do |n|
    n
  end

  factory :game do
    id
    association :player_black, factory: :user
    association :player_white, factory: :user
    name_for_game
  end

end
