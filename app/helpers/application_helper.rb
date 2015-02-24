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

  	def offend_player?
  		if Match.where("playing_first=? and winner is null",current_player.id).empty?
  			return false
  		else 
  			return true
  		end
  	end

    def isPartOfChampioship?
      championship=Championship.where(status:'ready').first;
      if !championship.nil?
        if ChampionshipPlayer.where('player_id=? and championship_id=?',current_player.id,championship.id).empty?
          return false;
        else 
          return true;
        end
      else
        return false;
      end

    end

    def isPlayerSecondMove?
      if Match.where("playing_second=? and winner is null and second_player_move is null and first_player_move is not null",current_player.id).first.nil?
        return false;
      else
        return true;
      end
    end  

    def isPlayerFirstMove?
       if Match.where("playing_first=? and winner is null and second_player_move is null and first_player_move is not null",current_player.id).first.nil?
        return true;
      else
        return false;
      end

    end  

end
