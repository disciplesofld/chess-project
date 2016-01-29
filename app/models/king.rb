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
  
  def is_check(x,y)
    blocking_piece = nil
    gp = self.game.game_pieces
    current_piece = gp.where(:x => x, :y => y)
    p "current piece fetched for"
    p x
    p y
    if (current_piece.first)
      p 'current piece not nil'
      if ( block_not_actual_piece(x,y) && (is_piece_alive?) && (is_block_opponent(current_piece)))
        p " block is there"
        p current_piece.first
        blocking_piece = current_piece.first 
      end
    end
    return blocking_piece
  end
  
  def next_cell?(x,desx)
    p 'check next cell'
    if (x == desx) || (x = desx+1) || (x = desx-1)
      p 'next cell'
      return true
    end
    return false
  end
  
  def straight_check(desx, piece)
    p 'straight_check'
    type = piece.type
    p type
    x = piece.x
    p x
    y = piece.y
    p y
    if (type == 'Queen' || type == 'Rook')
      p 'Queen/Rook'
      return true
    elsif (type=='King')
      p 'king'
      return next_cell?(x, desx)
    else
      return false
    end
  end
  
  def diagnol_check(desx, piece)
    p 'diagnol_check'
    type = piece.type
    x = piece.x
    y = piece.y
    if (type == 'Queen' || type == 'Bishop')
      p 'Queen/Bishop'
      return true
    elsif (type == 'King' || type == 'Pawn')
      p 'king/pawn'
      return next_cell?(x,desx)
    else
      return false
    end
  end
 
 # While scanning for opponent, skip the actual piece. 
  def block_not_actual_piece(block_x,block_y)
    p "block_not_actual_piece"
    p block_x
    p block_y
    p 'self x & y'
    p self.x
    p self.y
    
    if (( block_x == self.x) && (block_y == self.y))
      p 'actual piece'
      return false
      
    else
       p 'not actual piece'
      return true
    end
  end
  
  # Check the status of the piece and return true if it is alive
  def is_piece_alive?
    p "piece_alive"
    if(self.status == 1)
      return true
    else
      return false
    end
  end
  
  # Return true if the blocking piece is an opponent
  def is_block_opponent(current_piece)
    p "is_block_opponent"
    current_user_id = current_piece.pluck(:user_id)[0]
    if ( current_user_id == self.user_id)
      return false
    else
      return true
    end
  end
  
   # Returns the closest blocking opponent in the horizontal left direction
  def vertical_up_check(destination_x,destination_y)
    p "vertical_up_check"
    vertical_up_check = nil
    
    left = destination_y
    
    while !(left < 0) && !vertical_up_check do
      left -= 1
      vertical_up_check = is_check(destination_x,left)
      if vertical_up_check
        rval = straight_check(destination_x, vertical_up_check)
        p "return value"
        p rval
        return rval
      end
    end
    p "return value"
    p vertical_up_check
    return vertical_up_check
  end
  
    # Returns the closest blocking opponent in the horizontal right direction
  def vertical_down_check(destination_x,destination_y)
    p "vertical_down_check"
    vertical_down_check = nil
    right = destination_y
    while !(right > 7) && !vertical_down_check do
      right += 1
      vertical_down_check = is_check(destination_x,right)
      if vertical_down_check
        return straight_check(destination_x, vertical_down_check)
      end
    end
    return vertical_down_check
  end
   # Returns the closest blocking opponent in the vertical down direction
  def horizontal_right_check(destination_x,destination_y)
    p " horizontal_right_check"
    horizontal_right_check = nil
    bottom = destination_x
    while ! (bottom > 7) && !horizontal_right_check do
      bottom += 1
      horizontal_right_check = is_check(bottom, destination_y)
      if horizontal_right_check
        return straight_check(destination_x, horizontal_right_check)
      end
    end
    return horizontal_right_check
  end
  
  # Returns the closest blocking opponent in the vertical up direction
  def horizontal_left_check(destination_x,destination_y)
    p 'horizontal_left_check'
    horizontal_left_check = nil
    top = destination_x
    while ! (top < 0) && !horizontal_left_check do
      top -= 1
      horizontal_left_check = is_check(top,destination_y)
       if horizontal_left_check
        return straight_check(destination_x, horizontal_left_check)
      end
    end
    return horizontal_left_check
  end
  
   # Returns the closest blocking opponent in the diagnol left up direction
  def diagnol_left_up_check(destination_x,destination_y)
    p 'diagnol_left_up_check'
    incY = destination_y
    decX = destination_x
    diagnol_left_up_check = nil
    while !(decX < 0 && incY > 7) && !diagnol_left_up_check do
      decX -= 1
	    incY += 1
      diagnol_left_up_check = is_check(decX,incY)
      if diagnol_left_up_check
        return diagnol_check(destination_x, diagnol_left_up_check)
      end
    end
    return diagnol_left_up_check
  end
  
   # Returns the closest blocking opponent in the diagnol left down direction
  def diagnol_left_down_check(destination_x,destination_y)
    p 'diagnol_left_down_check'
    decY = destination_y
    incX = destination_x
    diagnol_left_down_check = nil
    while !(incX > 7 && decY < 0) && !diagnol_left_down_check do
      incX += 1
      decY -= 1
      diagnol_left_down_check = is_check(incX, decY)
      if diagnol_left_down_check
        return diagnol_check(destination_x, diagnol_left_down_check)
      end
    end
    return diagnol_left_down_check
  end
  
  # Returns the closest blocking opponent in the diagnol right up direction  
	def diagnol_right_up_check(destination_x,destination_y)
	  p 'diagnol_right_up_check'
	  diagnol_right_up_check = nil
    decY = destination_y
	  decX = destination_x
	  while !(decX < 0 && decY < 0) && !diagnol_right_up_check do
	    decY -=1
	    decX -=1
	    diagnol_right_up_check = is_check(decX, decY)
	    if diagnol_right_up_check
        return diagnol_check(destination_x, diagnol_right_up_check)
      end
	  end
	  return diagnol_right_up_check
	end
	
	# Returns the closest blocking opponent in the diagnol right down direction
	def diagnol_right_down_check(destination_x,destination_y)
	  p 'diagnol_right_down_check'
	  diagnol_right_down_check = nil
    incY = destination_y
	  incX = destination_x
	  while !(incX > 7 && incY > 7) && !diagnol_right_down_check do
	    incY +=1
	    incX +=1
	    diagnol_right_down_check = is_check(incX,incY)
	    if diagnol_right_down_check
        return diagnol_check(destination_x, diagnol_right_down_check)
      end
	  end
	  return diagnol_right_down_check
	end
	
		# Returns the closest blocking knight
	def knight_check(destination_x,destination_y)
	  p 'knight_check'
	  gp = self.game.game_pieces
	  knight_block = nil
    x = destination_x
    y = destination_y
    kinght_indices = [ [x-2,y+1], [x-2,y-1],[x-1,y-2], [x+1,y-2], [x+2,y-1], [x+2,y+1], [x+1,y+2], [x-1,y+2]]
    
    kinght_indices.each do |i|
      current_piece = gp.where(:x =>i[0], :y => i[1])
      p "current piece fetched for"
      p i[0]
      p i[1]
      if (current_piece.first && current_piece.pluck(:type)[0] == "Knight")
         p " knight_block is there"
        return true
      end
    end
    return knight_block
  end
	
		# This function checks for opponent in all directions and return true if there is an opponent
	# Input destination x position and destination y position
	def is_danger?(destination_x,destination_y)
    x = destination_x.to_i
    y = destination_y.to_i
    
    # This function will call the corresponding piece is_validate_rule function implemented in each piece model.
    # This function is not need for knight.
    if !(self.is_valid_rule?(x,y))
      return false
    end
    
    check = false
    p "Inside is_check"
    
    if (horizontal_left_check(x, y)||horizontal_right_check(x, y)|| \
      vertical_down_check(x, y) || vertical_up_check(x, y) || diagnol_left_up_check(x,y) \
      || diagnol_left_down_check(x,y) || diagnol_right_up_check(x,y) || diagnol_right_down_check(x,y) || knight_check(x,y))
      p "final check true"
      return true
    else
      p "final check fail"
      return false
    end
  end
end
