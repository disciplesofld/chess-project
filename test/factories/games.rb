FactoryGirl.define do
  sequence :name_for_game do |n|
    "game#{n}"
  end

  factory :game do
    association :player_black, factory: :user
    association :player_white, factory: :user
    name_for_game
  end
end
