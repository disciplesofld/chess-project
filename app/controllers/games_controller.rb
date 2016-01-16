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
    # add the following
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
    @game.populate_pieces
    @game.save
    if @game.valid?
      @game_pieces = @game.game_pieces
      #comment the following line for 'move' test
      redirect_to game_path
    end
    # uncomment these for 'move' test
    #@game_piece = GamePiece.where(game_id: [@game.id]).last #dummy value
    #new_x = 5 # test value = 5
    #new_y = 5 # test value = 5
    #@game_piece.move_piece(new_x, new_y) # testing to see if a piece moves to (5, 5)
    #@game_piece.save

  end

  def select
    @game = Game.find(params[:id])
    @x = params[:x]
    @y = params[:y]
  end

  def move
    @game = Game.find(params[:id])
    #@game_piece = GamePiece.where(game_id: [@game.id]).last #dummy value
    @game_piece = GamePiece.where(id: 3102).last
    @new_x = 1 # test value = 5
    @new_y = 7 # test value = 5
    if !@game.is_obstructed?(@game_piece, @new_x, @new_y)
      @game_piece.move_piece(@new_x, @new_y) # testing to see if a piece moves to (5, 5)
      @game_piece.save
    else
      # could have a message like the following?
      #flash[:notice] = "Obstructed!"
    end

    redirect_to game_path
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end

end
