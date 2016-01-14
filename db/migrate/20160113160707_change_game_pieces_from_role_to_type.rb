class ChangeGamePiecesFromRoleToType < ActiveRecord::Migration
  def change
    rename_column :game_pieces, :role, :type
  end
end
