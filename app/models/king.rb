class King < GamePiece
  
  def validate_king_rule(destination_x, destination_y)
    x = self.x
    y = self.y
    
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
  
  def block_not_actual_piece(block_x,block_y)
    if (( block_x == self.x) && (block_y == self.y))
      return false
    else
      return true
    end
  end
  
  def piece_alive(current_piece)
    if (current_piece.pluck(:status)[0] == 1)
      return true
    else
      return false
    end
  end
  
  def is_block_opponent(current_piece)
    current_user_id = current_piece.pluck(:user_id)[0]
    if ( current_user_id == self.user_id)
      return false
    else
      return true
    end
  end
  
  def horizontal_left_check(destination_x,destination_y)
    horizontal_left_block = nil
    gp = self.game.game_pieces 
    left = destination_y
    
    while not (left < 0) do
      current_piece = gp.where(:x => destination_x, :y => left)
      if ( block_not_actual_piece(x,left) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
        horizontal_left_block = current_piece 
        return horizontal_left_block
      end
      left -= 1
    end
    return horizontal_left_block
  end
  
  
  def horizontal_right_check(destination_x,destination_y)
    horizontal_right_block = nil
    gp = self.game.game_pieces
    right = destination_y
     
     while not (right > 7) do
       current_piece = gp.where(:x => destination_x, :y => right)
       if(block_not_actual_piece(x,right) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
          horizontal_right_block = current_piece
          return horizontal_right_block
        end
       
       right += 1
     end
     return horizontal_right_block
  end
  
  def vertical_down_check(destination_x,destination_y)
    vertical_down_check = nil
    block = false
    gp = self.game.game_pieces
    
    bottom = destination_x

    while not (bottom > 7) do
      current_piece = gp.where(:x => bottom, :y => destination_y)
      
      if (block_not_actual_piece(bottom,y) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
        vertical_down_check = current_piece
        return vertical_down_check
      end
      bottom += 1
        
    end
    return vertical_down_check
  end
  
  def vertical_up_check(destination_x,destination_y)
    vertical_down_check = nil
    block = false
    gp = self.game.game_pieces
    
    top = destination_x
    
    while not (top < 0) do
      current_piece = gp.where(:x=>top, :y=> destination_y)
      if (block_not_actual_piece(top,y) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
        vertical_down_check = current_piece
        return vertical_down_check
      end
      top -= 1
    end
    return vertical_down_check
  end
  
  def diagnol_left_up_check(destination_x,destination_y)
    diagnol_left_up_block = nil
    gp = self.game.game_pieces 
    incY = destination_y
    decX = destination_x
  
    while not ((decX < 0) && (incY > 7)) do
      current_piece = gp.where(:x => decX, :y => incY)
      if ( block_not_actual_piece(decX,incY) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
        diagnol_left_up_block = current_piece 
        return diagnol_left_up_block
      end
      decX -= 1
	    incY += 1
    end
    return diagnol_left_up_block
  end
  
  def diagnol_left_down_check(destination_x,destination_y)
    diagnol_left_down_block = nil
    gp = self.game.game_pieces 
    
    decY = destination_y
    incX = destination_x
    
    while not ((incX > 7) && (decY < 0)) do
      current_piece = gp.where(:x => incX, :y => decY)
      if ( block_not_actual_piece(incX,decY) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
        diagnol_left_down_block = current_piece
        return diagnol_left_down_block
      end
      incX += 1
      decY -= 1
    end
    return diagnol_left_down_block
  end
	  
	def diagnol_right_up_check(destination_x,destination_y)
	  diagnol_right_up_block = nil
    gp = self.game.game_pieces 
      
    decY = destination_y
	  decX = destination_x
	    
	  while not ((decX < 0) && (decY < 0)) do
	    current_piece = gp.where(:x => decX, :y => decY)
	    if ( block_not_actual_piece(decX,decY) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
	      diagnol_right_up_block = current_piece
	      return diagnol_right_up_block
	    end
	    decY -=1
	    decX -=1
	  end
	  return diagnol_right_up_block
	end
	
	def diagnol_right_down_check(destination_x,destination_y)
	  diagnol_right_down_block = nil
    gp = self.game.game_pieces 
      
    incY = destination_y
	  incX = destination_x
	    
	  while not ((incX > 7) && (incY > 7)) do
	    current_piece = gp.where(:x => incX, :y => incY)
	    if ( block_not_actual_piece(incX,incY) && (piece_alive(current_piece)) && (is_block_opponent(current_piece)))
	      diagnol_right_down_block = current_piece
	      return diagnol_right_down_block
	    end
	    incY +=1
	    incX +=1
	  end
	  return diagnol_right_down_block
	end
	
	def knight_check(destination_x,destination_y)
	  knight_block = nil
    gp = self.game.game_pieces 
    
    x = destination_x
    y = destination_y
    
    kinght_indices = [ [x-2,y+1], [x-2,y-1],[x-1,y-2], [x+1,y-2], [x+2,y-1], [x+2,y+1], [x+1,y+2], [x-1,y+2]]
    
    kinght_indices.each do |i|
      current_piece = gp.where(:x =>i[0], :y => i[1])
      if (current_piece.pluck(:type)[0] == "Knight")
        return knight_block = current_piece
      end
    end
    return knight_block
    
	end
	
	def is_check(destination_x,destination_y)
      x = destination_x.to_i
      y = destination_y.to_i
      
      if not (validate_king_rule(x,y))
        return false
      end
      
      check = false
      
      horizon_left_block = horizontal_left_check(x, y)
      horizon_right_block = horizontal_right_check(x, y)
      vertical_down_block = vertical_down_check(x, y)
      vertical_up_block = vertical_up_check(x, y)
      diagnol_left_up_block = diagnol_left_up_check(x,y)
      diagnol_left_down_block = diagnol_left_down_check(x,y)
      diagnol_right_up_block = diagnol_right_up_check(x,y)
      diagnol_right_down_block = diagnol_right_down_check(x,y)
      knight_block = knight_check(x,y)
      
      if(horizon_left_block)
        type = horizon_left_block.pluck(:type)[0]
        if ( type == "Queen" || type == "Rook" )
          check = true
        elsif (type == "King")
          #Opponent king in next cell
          if (horizon_left_block.pluck(:y)[0] == y+1)
            check = true
          end
        else
          check = false
        end
      end
      
      if not (check)
        if(horizon_right_block)
          type = horizon_right_block.pluck(:type)[0]
          if ( type == "Queen" || type == "Rook" )
            check = true
          elsif (type == "King")
            #Opponent king in next cell
            if (horizon_left_block.pluck(:y)[0] == y-1)
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if(vertical_up_block)
          type = vertical_up_block.pluck(:type)[0]
          if ( type == "Queen" || type == "Rook" )
            check = true
          elsif (type == "King")
            #Opponent king in next cell
            if (vertical_up_block.pluck(:x)[0] == x-1)
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if(vertical_down_block)
          type = vertical_down_block.pluck(:type)[0]
          if ( type == "Queen" || type == "Rook" )
            check = true
          elsif (type == "King")
            #Opponent king in next cell
            if (vertical_down_block.pluck(:x)[0] == x+1)
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if (diagnol_left_up_block)
          type = diagnol_left_up_block.pluck(:type)[0]
          if (type == "Queen" || type == "Bishop")
            check = true
          elsif (type == "King" || type == "Pawn")
            #Opponent king/Pawn in next cell
            if ((diagnol_left_up_block.pluck(:x)[0] == x-1)&&(diagnol_left_up_block.pluck(:y)[0] == y+1))
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if (diagnol_left_down_block)
          type = diagnol_left_down_block.pluck(:type)[0]
          if (type == "Queen" || type == "Bishop")
            check = true
          elsif (type == "King" || type == "Pawn")
            #Opponent king/Pawn in next cell
            if ((diagnol_left_down_block.pluck(:x)[0] == x+1)&&(diagnol_left_down_block.pluck(:y)[0] == y-1))
              check = true
            end
          else
            check = false
          end
        end
      end
    
      if not (check)
        if (diagnol_right_up_block)
          type = diagnol_right_up_block.pluck(:type)[0]
          if (type == "Queen" || type == "Bishop")
            check = true
          elsif (type == "King" || type == "Pawn")
            #Opponent king/Pawn in next cell
            if ((diagnol_right_up_block.pluck(:x)[0] == x-1)&&(diagnol_right_up_block.pluck(:y)[0] == y-1))
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if (diagnol_right_down_block)
          type = diagnol_right_down_block.pluck(:type)[0]
          if (type == "Queen" || type == "Bishop")
            check = true
          elsif (type == "King" || type == "Pawn")
            #Opponent king/Pawn in next cell
            if ((diagnol_right_down_block.pluck(:x)[0] == x+1)&&(diagnol_right_down_block.pluck(:y)[0] == y+1))
              check = true
            end
          else
            check = false
          end
        end
      end
      
      if not (check)
        if (knight_block)
          check = true
        end
      end
      return check
  end
    
end

