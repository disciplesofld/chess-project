class King < GamePiece
  
  def validate_king_rule(destination_x, destination_y)
    #call is_obstructed
    x = self.x
    y = self.y
    
    valid = false
    
    valid_indices = [ [x-1,y-1], [x-1,y],[x,y+2], [x,y-1], [x,y+2], [x+1,y-1], [x+1,y], [x+1,y+1]]
    
    valid_indices.each do |i|
      if (destination_x == i[0]) && (destination_y == i[1])
        valid = true
        break
      end
    end
    
    return valid
    
  end
  

end
