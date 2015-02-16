class PlayerSessionsController < ApplicationController
	def new
	end

	def create
		player=Player.find_by_name(params[:player_sessions][:name])
		if player && player.authenticate(params[:player_sessions][:password])
			log_in player
      		redirect_to root_url,status:200
		else
			flash[:danger] = 'Invalid email/password combination'
			render 'new',status:401
		end
	end

	def destroy
		logout
		redirect_to root_url
	end

end
