class GamesController < ApplicationController
	before_action :authenticate_user!

	def index
		@game = Game.all
		# if @game.present?
		# 	redirect_to game_path(@game)
		# else
		# 	render :show
		# end
	end

	def show
		@game = Game.find(params[:id])
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
		render :index
	end

	private

	def game_params
		params.require(:game).permit(:player_white_id, :player_black_id, :name_for_game)
	end

end
