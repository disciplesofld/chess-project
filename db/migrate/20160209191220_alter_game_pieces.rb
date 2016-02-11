class AlterGamePieces < ActiveRecord::Migration

  def change
    remove_column :game_pieces, :moved, :boolean, :default => false
    add_column :game_pieces, :moved, :integer, :default => 0
  end

end
