class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = Game.all
  end

  def show
    # Determine if the game is won
    @winner = nil
    @game = Game.find(params[:id])
    @users = User.all
    won = @game.won
    if won != nil
      @winner = @users.find(@game.won).email
    end
    
    @game_pieces = @game.game_pieces
    @resign_message = nil
    if @game.player_white_id == -1
      @resign_message = "Player Black Won! (Player White Has Left the Match)"
    elsif  @game.player_black_id == -1
      @resign_message = "Player White Won! (Player Black Has Left the Match)"
    end

  end

  def create
    @game = Game.create(game_params)
    redirect_to games_path
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    @game.populate_pieces!
    if @game.valid?
      @game_pieces = @game.game_pieces
      redirect_to game_path
    end
  end

  def select
    @game = Game.find(params[:id]) # blah blah blah
    @game_pieces = @game.game_pieces
    @game_piece = GamePiece.find(params[:game_piece_id])
  end

  def move
    @game = Game.find(params[:id])
    @game_pieces = @game.game_pieces
    @game_piece = GamePiece.find(params[:game_piece_id])
    # NOTE converting to integer here saves you from having to do it in every piece
    new_x = params[:new_x].to_i
    new_y = params[:new_y].to_i

    if @game.check_player(@game_piece, current_user, new_x, new_y) && @game_piece.valid_move?(new_x, new_y)
      #Capture piece if capture_move? return true
      if @game.capture_move?(@game_piece, new_x, new_y)
        move_save(new_x, new_y)
      end

      # TODO if the piece is a king, it cannot be moved into check
      if @game_piece.type == 'King'
        opponent = @game.get_enemy_of(@game_piece.user_id)
        if !@game.can_attack?(opponent, new_x, new_y)
          move_save(new_x, new_y)
        else
          flash[:notice] = "King cannot be moved in check position!"
        end
      elsif @game_piece.type == 'Pawn'
        # check if it reached y = 0 or y = 7
        if new_y==0 || new_y == 7
	        p "check if pawn reaches other end"
	        # then change the type to queen.
	        @game_piece.type = 'Queen'
	        @game_piece = @game_piece.becomes(@game_piece.type.constantize)
	      end
	      # call move and save
	      move_save(new_x, new_y)
      else
        move_save(new_x, new_y)
      end
    else
      # can't move there!
      flash[:notice] = "Invalid move"
    end
    base_uri = 'https://vivid-heat-2313.firebaseIO.com/'
    firebase = Firebase::Client.new(base_uri)
    response = firebase.set("#{@game.id}",  :created => Firebase::ServerValue::TIMESTAMP)
    # response.success? # => true

    redirect_to game_path
  end

  def destroy
    @game = Game.find(params[:id])
    @game_pieces = @game.game_pieces
    if @game.player_white == current_user
      @game.player_white_id = -1

      flash[:notice] = "Player Black Won!"
    else
      @game.player_black_id = -1
      flash[:notice] = "Player White Won!"
    end
    @game.destroy
    # to-do
    # need to add code here for a winning player
    # (points add?  number of winning game added for a winner?)
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end

  def move_save(new_x, new_y)
    @game_piece.move_to(new_x, new_y)
    @game_piece.save

    if @game.check_mate?(@game_piece.user_id)
      flash[:error] = "checkmate"
      @winner = (@game.player_black == current_user)? @game.player_black : @game.player_white
      flash[:notice] = "Game Over"
      @game.save_winner(@winner.id)
    elsif @game.in_check?(@game_piece.user_id)
      flash[:error] = "check"
    end

  end

end
