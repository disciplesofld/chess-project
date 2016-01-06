class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_white_id
      t.integer :player_black_id
      t.string :name_for_game

      t.timestamps
    end
  end
end
