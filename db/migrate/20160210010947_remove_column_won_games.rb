class RemoveColumnWonGames < ActiveRecord::Migration
  def change
    remove_column :games, :won, :integer
  end
end
