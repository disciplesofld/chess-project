class AddGameWonColumn < ActiveRecord::Migration
  def change
    add_column :games, :won, :integer
  end
end
