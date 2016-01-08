class GamesController < ApplicationController
	def index
		if @game.present?
			redirect_to game_path(@game)
		else
			render :show
		end
	end

	def show
	end

end
