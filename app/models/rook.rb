class Rook < GamePiece

	def valid_move?(new_x, new_y)
		# cannot land on similar player piece - handled by is_obstructed? method, game.rb
		# any pieces in path from start to finish? - handled by is_obstructed? method, game.rb
		move_x = new_x.to_i
		move_y = new_y.to_i

		# self.x Column index
		# self.y Row index (reversed: bottom-to-top)
		# Only (vertically) || only (horizontally)
		if ((self.x == move_x) && (self.y > move_y || self.y < move_y)) || ((self.y == move_y) && (self.x > move_x || self.x < move_x))
		# if self.x == new_x.to_i
			self.move_piece(new_x, new_y)
			return true
		end
	end

end
