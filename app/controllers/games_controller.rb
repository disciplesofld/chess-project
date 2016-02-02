class GamesController < ApplicationController

  before_action :authenticate_user!

  def index
    @game = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @game_pieces = @game.game_pieces
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
    @game = Game.find(params[:id])
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
    # TODO: check if the new x & y values are in bounds
    if !@game.is_obstructed?(@game_piece, new_x, new_y) && @game_piece.valid_move?(new_x, new_y)
      # TODO if the piece is a king, it cannot be moved into check
      if @game_piece.type == 'King'
        p @game_piece.user_id
        opponent = @game.get_enemy_of(@game_piece.user_id)
        if !@game.can_attack?(opponent, new_x, new_y)
          p "call can attack from controller"
         move_save(new_x, new_y)
        else
          flash[:notice] = "King cannot be moved in check position!"
        end
      else
       move_save(new_x, new_y)
      end
    else
      # can't move there!
      flash[:notice] = "Invalid move"
    end
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end
  
  def move_save(new_x, new_y)
    @game_piece.move_to(new_x, new_y)
    @game_piece.save
  end

end
