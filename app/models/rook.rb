class Rook < GamePiece
  # parameters should be converted to intgers in caller
	def valid_move?(new_x, new_y)
		# cannot land on similar player piece - handled by is_obstructed? method, game.rb
		# any pieces in path from start to finish? - handled by is_obstructed? method, game.rb

		# self.x = Column index; self.y = Row index (reversed: bottom-to-top)
		# Moves only (vertically) || only (horizontally)
		if ((self.x == new_x) && (self.y > new_y || self.y < new_y)) || ((self.y == new_y) && (self.x > new_x || self.x < new_x))
			# self.move_to(new_x, new_y) - now obtaining function from game_pieces.rb
			return true
		end
	end

	def icon
			image = "&#9820;"
			return image.html_safe

  end

end
