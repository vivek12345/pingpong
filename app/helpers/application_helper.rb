module ApplicationHelper
  	def signed_in_player
		redirect_to root_url, notice: "Please sign in.",status:401 unless logged_in?
	end

	def log_in(player)
    session[:player_id] = player.id
  	end

  	def current_player
  		@current_player||=Player.find_by_id(session[:player_id])
  	end

  	def logged_in?
  		!current_player.nil?
  	end

  	def logout
  		session.delete(:player_id)
  		@current_player=nil
  	end

  	def refree?
  		if current_player
  			if current_player.role=="0"
  			current_player
  		end
  		end
  	end
end
