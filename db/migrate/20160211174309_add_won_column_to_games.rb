class AddWonColumnToGames < ActiveRecord::Migration
  def change
    add_column :games, :won, :integer
  end
end
