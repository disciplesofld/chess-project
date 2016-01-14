class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @game = Game.all
    # if @game.present?
    #   redirect_to game_path(@game)
    # else
    #   render :show
    # end
  end

  def show
    @game = Game.find(params[:id])
    @game.populate_pieces
    @game_pieces = @game.game_pieces
  end


  def create
    @game = Game.create(game_params)
    redirect_to games_path
  end

  def edit
    @game = Game.find(params[:id])
    # render :index
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    # @game.populate_pieces HIROMI
    # @game.save  HIROMI
    if @game.valid?
      # @game_pieces = @game.game_pieces  HIROMI
      redirect_to game_path  # commented out to see if pieces is populated. change this later.
    end
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end

end
