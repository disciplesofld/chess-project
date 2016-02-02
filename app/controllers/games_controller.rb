class GamesController < ApplicationController

  before_action :authenticate_user!

  def index
    @game = Game.all
  end

  def show
    @game = Game.find(params[:id])
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
      # if <piece is a king>
      #   enemy_player = @game.get_enemy_of(current_player.id)
      #   if @game.can_attack_square(enemy_player, new_x, new_y)
      #     # enemy can attack your king here, invalid move! do something about it
      #   end
      # end
      @game_piece.move_to(new_x, new_y)
      @game_piece.save
    else
      # can't move there!
      flash[:notice] = "Invalid move"
    end
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
    @game.save
    # to-do
    # need to add code here for a winning player
    # (points add?  number of winning game added for a winner?)
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
  end

end
