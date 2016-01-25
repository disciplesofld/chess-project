class Game < ActiveRecord::Base
  has_many :game_pieces
  belongs_to :player_white, :class_name => "User", :foreign_key => "player_white_id"
  belongs_to :player_black, :class_name => "User", :foreign_key => "player_black_id"

  def populate_pieces!
    game_piece_rank = ["Rook", "Knight", "Bishop", "Queen", "King", "Bishop", "Knight", "Rook"]
    (0..7).each do |i|
      game_pieces << (game_piece_rank[i].constantize).new(x: i, y: 0, status: 1, game_id: self.id, user_id: player_white_id)  #player 1
      game_pieces << Pawn.new(x: i, y: 1, status: 1, game_id: self.id, user_id: player_white_id)  #player 1
      game_pieces << (game_piece_rank[i].constantize).new(x: i, y: 7, status: 1, game_id: self.id, user_id: player_black_id)  #player 2
      game_pieces << Pawn.new(x: i, y: 6, status: 1, game_id: self.id, user_id: player_black_id)  #player 2
    end
  end

  def add_piece(piece)
    piece.game_id = self.id
    piece.save
    game_pieces << piece
  end

  # - check for obstructions between a piece and its requested destination.
  # - along the path to the destination, any piece is an obstruction.
  # - a piece can only be obstructed at its destination by a friendly piece because
  #   enemy pieces can be taken.
  def is_obstructed_new?(piece, dest_x, dest_y)
    return true if destination_is_obstructed?(piece, dest_x, dest_y)

    start_x = piece.x
    start_y = piece.y

    if start_y == dest_y && start_x != dest_x
      # horizontal
      return path_is_obs_horizontal(start_x, dest_x, piece.y)
    elsif start_x == dest_x && start_y != dest_y
      # vertical
      return path_is_obs_vertical(start_y, dest_y, piece.x)
    elsif (dest_x - start_x).abs == (dest_y - start_y).abs
      # diagonal
      return path_is_obs_diagonal(start_x, dest_x, start_y, dest_y)
    else
      # unknown move type, can't check
      return false
    end
  end

  def destination_is_obstructed?(piece, dest_x, dest_y)
    # check final position, only blocked if friendly piece is there
    blocker = game_pieces.find_by_x_and_y(dest_x, dest_y)
    return blocker.present? && blocker.user_id == piece.user_id
  end

  def path_is_obs_horizontal(start_x, dest_x, y)
    dx = dest_x - start_x
    step_x = dx / dx.abs
    start_x = start_x + step_x  # don't check this piece's position
    dest_x = dest_x - step_x    # don't check the final position

    start_x.step(dest_x, step_x) do |x|
      blocker = game_pieces.where(x: x, y: y)
      return true if blocker.present?
    end

    false
  end

  def path_is_obs_vertical(start_y, dest_y, x)
    dy = dest_y - start_y
    step_y = dy / dy.abs
    start_y = start_y + step_y
    dest_y = dest_y - step_y

    start_y.step(dest_y, step_y) do |y|
      blocker = game_pieces.where(x: x, y: y)
      return true if blocker.present?
    end

    false
  end

  def path_is_obs_diagonal(start_x, dest_x, start_y, dest_y)
    dx = dest_x - start_x
    step_x = dx / dx.abs
    start_x = start_x + step_x  # don't check this piece's position
    dest_x = dest_x - step_x    # don't check the final position

    dy = dest_y - start_y
    step_y = dy / dy.abs
    y = start_y + step_y
    start_x.step(dest_x, step_x) do |x|
      blocker = game_pieces.where(x: x, y: y)
      return true if blocker.present?
      y += step_y
    end

    false
  end

  def is_obstructed?(gamepiece, new_x, new_y)
    # from game_controller.rb, this should probably be called :
    # if !@game.is_obstructed?(@game_piece, @new_x, @new_y)
    #   @game_piece.move_to(@new_x, @new_y) <- move only if it is NOT obstructed
    #
    current_x = gamepiece.x
    current_y = gamepiece.y
    new_x = new_x.to_i
    new_y = new_y.to_i
    team_id = gamepiece.user_id

    # return true means there is obstruction in movement --> that means bad
    if is_occupied_by_teammate?(current_x, current_y, new_x, new_y, team_id, gamepiece.id)
      return true
    end

    if gamepiece.type == "Knight"
      return false
    end
    #assumption is that the piece won't move to the same place.
    #e.g., [2, 2] -> [2, 2]
    #that validation is done before reaching to is_obstructed? method

    #check if the move is horizontal
    if current_y == new_y
      if is_horizontal_ok?(current_x, current_y, new_x, new_y) == false
        return true
      end
    end

    #check if the move is vertical
    if current_x == new_x
      if is_vertical_ok?(current_x, current_y, new_x, new_y) == false
        return true
      end
    end

    #check if the move is diagonal
    if ((new_x - current_x).abs == (new_y - current_y).abs)
      if is_diagonal_ok?(current_x, current_y, new_x, new_y) == false
        return true
      end
    end

    return false

  end

  def is_occupied_by_teammate?(current_x, current_y, new_x, new_y, team_id, gamepiece_id)
    game_pieces.each do |game_piece|
      if (game_piece.x == new_x && game_piece.y == new_y && game_piece.user_id == team_id && game_piece.id != gamepiece_id)
        return true
      end
    end
    return false
  end

  def is_horizontal_ok?(current_x, current_y, new_x, new_y)
    x2 = new_x  # x2 value is larger than x1
    x1 = current_x
    if new_x < current_x
      x2 = current_x
      x1 = new_x
    end
    # create array of x.  If game_piece.x is the same as one of array of x,
    # there is an obstruction.
    # only need to check between x1 and x2 values; x1 and x2 are not included.
    # x1+1 to exclude x1 point.  Using ... to exclude x2
    x_array = ((x1+1)...x2).map {|i| i}
    game_pieces.each do |game_piece|
      if x_array.include?(game_piece.x) && game_piece.y == current_y
        return false  # false means horizontal_move is NOT ok
      end
    end
    return true
  end

  def is_vertical_ok?(current_x, current_y, new_x, new_y)
    y2 = new_y  # y2 value is larger than y1
    y1 = current_y
    if new_y < current_y
      y2 = current_y
      y1 = new_y
    end
    # create array of y.  If game_piece.y is the same as one of array of y,
    # there is an obstruction.
    y_array = ((y1+1)...y2).map {|i| i}
    game_pieces.each do |game_piece|
      if y_array.include?(game_piece.y) && game_piece.x == current_x
        return false  # false means horizontal_move is NOT ok
      end
    end
    return true
  end

  def is_diagonal_ok?(current_x, current_y, new_x, new_y)

    two_d_array = []

    if (new_y > current_y && new_x > current_x)  # piece moves to up right
      two_d_array = create_two_d_array_for_diagonal_check(current_x+1, current_y+1, current_y+1, new_y, 1, 1, two_d_array)

    elsif (new_y > current_y && new_x < current_x) # piece moves to up left
      two_d_array = create_two_d_array_for_diagonal_check(current_x-1, current_y+1, current_y+1, new_y, -1, 1, two_d_array)

    elsif (new_y < current_y && new_x > current_x) # piece moves to down right
      two_d_array = create_two_d_array_for_diagonal_check(current_x+1, current_y-1, current_x+1, new_x, 1, -1, two_d_array)

    else # new_y < current_y && new_x < current_x.  piece moves to down left
      two_d_array = create_two_d_array_for_diagonal_check(current_x-1, current_y-1, new_x, current_x-1, -1, -1, two_d_array)
    end

    # this loop checks all game_piece to see if there is an obstrucle.
    found_match = false
    game_pieces.each do |game_piece|
      piece_ary = [game_piece.x, game_piece.y]
      two_d_array.each do |ary|
        if piece_ary == ary
          found_match = true
        end
      end
    end

    if found_match
      return false
    else
      return true
    end
  end

  def create_two_d_array_for_diagonal_check(x, y, loop_init, loop_end, x_incr, y_incr, two_d_array)
    # this create a two-dimensional array for all squares between current position and new_position.
    # current position and new position are excluded from the array.
    # for example, if the piece moves from [2, 1] to [5, 4], the array should contains
    # [[3, 2], [4, 3]].
    i = loop_init
    while i < loop_end
      two_d_array  << [x, y]
      x += x_incr
      y += y_incr
      i += 1
    end
    return two_d_array
  end
end
