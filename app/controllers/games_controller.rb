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
    if !@game.is_obstructed?(@game_piece, params[:new_x], params[:new_y]) # PUT THIS ACCESS IN ALL PIECE TYPE MODELS!!!!
      if @game_piece.move_piece(params[:new_x], params[:new_y]) # SET THIS TO RECEIVE BOOL
        @game_piece.save
      else
        flash[:notice] = "Not a valid move for #{game_piece.type}"
      end

    else # the piece is obstructed
      flash[:notice] = "The piece is obstructed!"
    end
    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end

end
