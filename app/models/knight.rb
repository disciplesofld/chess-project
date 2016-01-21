class Knight < GamePiece

	def move_piece(new_x, new_y)
        current_x = self.x
        current_y = self.y
        next_x = new_x.to_i
        next_y = new_y.to_i
        #if match the rule of knight, move to the new position
        if is_move_validated?(current_x, current_y, next_x, next_y)
            self.update_attributes(:x => new_x, :y => new_y)
        end
    end

        
    def is_move_validated?(current_x, current_y, next_x, next_y)
        #return false if piece doen't move
        return false if current_x == next_x && current_y == next_y

        # define the rule of knight
        if (current_x - next_x).abs + (current_y - next_y).abs == 3
            return true
        else
            return false
        end
    end

end
