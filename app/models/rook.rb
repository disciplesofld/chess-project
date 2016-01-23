class Rook < GamePiece

	def valid_move?(new_x, new_y)
		# cannot land on similar player piece - handled by is_obstructed? method, game.rb
		# any pieces in path from start to finish? - handled by is_obstructed? method, game.rb

		# self.x Column index
		# self.y Row index (reversed: bottom-to-top)

		# Only (vertically) || only (horizontally)
		if (self.x == new_x && (self.y > new_y || self.y < new_y)) \
			|| (self.y == new_y && (self.x > new_x || self.x < new_x))
			return true
		else
			return false
		end
	end

end
