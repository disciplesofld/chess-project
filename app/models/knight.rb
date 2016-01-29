class Knight < GamePiece

  # TODO remove. no need for this here
	# def move_piece(new_x, new_y)
  #       current_x = self.x
  #       current_y = self.y
  #       next_x = new_x.to_i
  #       next_y = new_y.to_i
  #       #if match the rule of knight, move to the new position
  #       if is_move_validated?(current_x, current_y, next_x, next_y)
  #           self.update_attributes(:x => new_x, :y => new_y)
  #       end
  #   end

    def valid_move?(next_x, next_y)
      # these values should be converted to integers before being passed in, if it is necessary
			n_x = next_x.to_i
	    n_y = next_y.to_i

      #return false if piece doen't move
			# Not needed anymore; current location not available as a move (Sherilyn)
      # return false if self.x == n_x && self.y == n_y

      # define the rule of knight
      if (self.x - n_x).abs + (self.y - n_y).abs == 3
				self.move_piece(next_x, next_y)
        return true
      else
        return false
      end
    end

end
