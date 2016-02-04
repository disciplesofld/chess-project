class AddColumnsToGamePieces < ActiveRecord::Migration
  def change
    add_column :game_pieces, :alive, :boolean, :default => true
    add_column :game_pieces, :selected, :boolean, :default => false
    add_column :game_pieces, :moved, :boolean, :default => false
  end
end
