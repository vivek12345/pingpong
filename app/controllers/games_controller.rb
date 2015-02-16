class GamesController < ApplicationController
	def add
		@championship=Championship.find_by_id(params[:championship_id])
		championship_id=params[:championship_id]
		level=params[:level]
		players=params[:players]
		i=0
		if level==0
		i=0
		end
		if level==1
		i=4
		end
		if level==2
		i=6
		end
		k=0
		until i>7
			@game=@championship.games.create(level:level,player1:players[k][:player_id],player2:players[k+1][:player_id])
			@game.matches.create(game_id:@game.id,playing_first:@game.player1,playing_second:@game.player2)
			i=i+2
			k=k+2
		end
		redirect_to root_url,status:201
		flash[:success]="Game Created"

	end
end
