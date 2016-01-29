FactoryGirl.define do
  factory :game_piece, class: 'GamePiece' do
    user
    game
    
    x 0
    y 0
    type 'King'
    status 0
  end
  
  factory :king, parent: :game_piece, class: 'King' do
  end
  
  factory :queen, parent: :game_piece, class: 'Queen' do
  end
  
  factory :knight, parent: :game_piece, class: 'Knight' do
  end
  
  factory :bishop, parent: :game_piece, class: 'Bishop' do
  end
  
  factory :rook, parent: :game_piece, class: 'Rook' do
  end
  
  factory :pawn, parent: :game_piece, class: 'Pawn' do
  end

end

