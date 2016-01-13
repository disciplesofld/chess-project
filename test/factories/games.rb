FactoryGirl.define do

  sequence :name_for_game do |n|
    "game#{n}"
  end

  sequence :id do |n|
    n
  end

  factory :game do
    id
    player_black_id 1 # 1st user
    player_white_id 0 # 1st user
    name_for_game
  end

end
