FactoryGirl.define do
  factory :game_piece do
    user
    game
    
    x 0
    y 0
    type 'King'
    status 0
  end

end
