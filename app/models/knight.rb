class Knight < GamePiece



        
    def is_move_validated?(new_x, new_y)
        #return false if piece doen't move
        return false if self.x == new_x&& self.y == new_y

        # define the rule of knight
        if (self.x.to_i - new_x.to_i).abs + (self.y.to_i - new_y.to_i).abs == 3
            return true
        else
            return false
        end
    end

end
