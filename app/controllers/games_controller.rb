class GamesController < ApplicationController
	def add
		@championship=Championship.find_by_id(params[:championship_id])
		championship_id=params[:championship_id]
		level=params[:level]
		players=params[:players]
		i=0
		until i>7
			@game=@championship.games.create(level:level,player1:players[i][:player_id],player2:players[i+1][:player_id])
			@game.matches.create(game_id:@game.id,playing_first:@game.player1,playing_second:@game.player2)
			i=i+2
		end
		redirect_to root_url,status:201
		flash[:success]="Game Created"

	end
end
