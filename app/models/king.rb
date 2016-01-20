class King < GamePiece
  
  def is_valid_rule?(destination_x, destination_y)
    x = self.x
    y = self.y
    p "is_valid_rule #{self.type}"
    valid = false
    
    valid_indices = [[x-1,y+1], [x-1,y],[x-1,y-1], [x,y-1], [x+1,y-1], [x+1,y], [x+1,y+1], [x,y+1]]
    
    valid_indices.each do |i|
      if (destination_x == i[0]) && (destination_y == i[1])
        valid = true
        break
      end
    end
    return valid
  end
	
end
	