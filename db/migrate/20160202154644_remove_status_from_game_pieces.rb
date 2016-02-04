class RemoveStatusFromGamePieces < ActiveRecord::Migration
  def change
    remove_column :game_pieces, :status, :integer
  end
end
