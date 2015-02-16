class ChampionshipController < ApplicationController
before_filter :signed_in_player
	def create
		@championship=Championship.where(status:'ready') | Championship.where(status:'wait')
		if @championship.nil?
			Championship.create(status:"wait")
			redirect_to root_url,status:201
			flash[:success]="Champioship Created"
		else
			redirect_to root_url,status:403
			flash[:notice]="A championship is already created"

		end

	end

	def join
		@championship=Championship.find_by_status('wait')
		if @championship.nil?
			redirect_to root_url,status:403
			return
		else
			championship_id=@championship.id
			championship_players=0
			if @championship.championship_players.any?
				@championship.championship_players.each do |player|
					if player.player_id==current_player.id
						redirect_to root_url,status:403
						flash[:danger]="You are already part of this championship"
						return
					end
				end
			end
			@championship.championship_players.create(player_id: current_player.id)
			championship_players=@championship.championship_players.size

		end
		if championship_players==8
			changeStatus(@championship,'ready',nil)
		else
			redirect_to root_url,status:201
			flash[:success]="Joined championship"
		end
		return
	end	

	def changeStatus(this,status,winner)
		if status=="complete"
			this.update_attributes(status:'complete')
		end
		this.save
		if status=="ready"
		this.update_attributes(status:'ready')
		game_info={
			championship_id: this.id,
			level: 0,
			players:this.championship_players.map do |p|
				{
					player_id:p.player_id
				}
			end
		}
		redirect_to create_game_path(game_info)
		end
	end


	def player_status
		if !refree?
			@championship=Championship.find_by_status('ready')
			if !@championship.nil?
				game=getGame(@championship.id,current_player.id)
				if !game.nil?
					match=getMatch(game.id,current_player.id)
					if match.playing_first==current_player.id
						redirect_to root_url,status:200
						flash[:success]="Play your move select a number"
						return
					else
						if match.first_player_move.nil?
							redirect_to root_url,status:200
							flash[:success]="Waiting for player 1 to play"
							return
						else
							redirect_to root_url,status:200
							flash[:success]="Please play your move"
							return
						end
					end
				else
					redirect_to root_url,status:200
					flash[:notice]="Waiting for other games of this level to finish"
					return
				end
			else
				redirect_to root_url,status:202
				flash[:notice]="Waiting for other payers to join"
				return
			end

		end

	end

	def getGame(id,player_id)
			@game=Game.where("championship_id = ? AND player1 = ? AND winner is null",id,player_id) | Game.where("championship_id=? and player2=? and winner is null",id,player_id)
			@game=@game.first
	end

	def getMatch(game_id,player_id)
			@match=Match.where("game_id=? and playing_first=? and winner is null",game_id,player_id) | Match.where("game_id=? and playing_second=? and winner is null",game_id,player_id)
			@match=@match.first
	end

	def offend
		i=2
		if i>=1 && i<=10
			match=Match.where("playing_first=? and winner is null and first_player_move is null",current_player.id).first
			if !match.nil?
				match.first_player_move=i
				if match.save
					redirect_to root_url,status:200
					flash[:success]="your move is saved,now wait for the second player"
					return
				else
					redirect_to root_url,status:500
					flash[:danger]="Due to some error your move cant be saved,click on offend again"
					return
				end
				match=nil

			else
				match=Match.where("playing_second=?",current_player.id)
				if !match.nil?
					redirect_to root_url,status:400
					flash[:success]="You have to defend,you cannot offend"
					return
				else
					redirect_to root_url,status:400
					flash[:notice]="No match found,click on status to get the updated status of your match"
					return
				end
			end
		else
			redirect_to root_url,status:400
			flash[:danger]="Invalid number,it shuld be between 1 and 10"
			return
		end
	end

	def defend
		i=[5,6,3,4,8,7,4,1]
		if i.length==current_player.defence_set_length
			match=Match.where("playing_second=? and winner is null and second_player_move is null and first_player_move is not null",current_player.id).first
			if !match.nil?
				match.second_player_move=i[0]
				match.save
				if getWinner(match.first_player_move,i)
					match.winner=current_player.id
					match.playing_second=match.playing_first
					match.playing_first=current_player.id
					
				else
					match.winner=match.playing_first
					match.playing_first=match.playing_first
					match.playing_second=match.playing_second
				end
				if match.save
					redirect_to root_url,status:200
					flash[:success]="Match Details Saved"
					
				else
					redirect_to root_url,status:400
					flash[:success]="Sorry,due to some error we could not save the match details"
					return
				end
				game_id=match.game_id
				match_stats=getGameStatus(game_id)
				@gamewinner=nil
				if match_stats.count>=1
					updateGameWinner(game_id,match.playing_first)
					@gamewinner=match.playing_first

				end
				#if match_stats.winner==match.playing_second && match_stats.count==5
				#	updateGameWinner(game_id,match.playing_second)
				#	@gamewinner=match.playing_second
				#end
				if(@gamewinner.nil?)
					@game=Game.find_by_id(game_id)
					@game.matches.create(game_id:@game.id,playing_first:match.playing_first,playing_second:match.playing_second)
					flash[:notice]="No match found,click on status to get the updated status of your match"
			
				end

			else
				#redirect_to root_url,status:400 and return
				flash[:notice]="No match found,click on status to get the updated status of your match"
			end 

		else
			#redirect_to root_url,status:400 and return
			flash[:danger]="Your defence array should be of the sie 4"
			
		end

	end

	def getWinner(first_move,i)
		i.include?(first_move)
	end

	def getGameStatus(game_id)
		match=Match.all(select:"count(*) as count,winner",group:"winner",having:["game_id=?",game_id])
		match=match.first
	end

	def updateGameWinner(game_id,winner)
		game=Game.find_by_id(game_id)
		game.winner=winner
		game.status="completed"
		game.save
		championship_id=game.championship_id
		@championship=Championship.find_by_id(championship_id)
		level=game.level
		newGame=getGameStats(championship_id,level)
		if newGame.nil?
			players=getGamePlayers(championship_id,level)
			if level==2
				changeStatus(@championship,'complete',players[0][player_id])
			else
				game_info={
					championship_id: championship_id,
					level: level+1,
					players:players.map do |p|
					{
						player_id:p.player_id
					}
					end
				}
				redirect_to create_game_path(game_info)

			end
		end
		return
	end

	def getGameStats(id,level)
		game=Game.where("championship_id=? and level=? and winner is null",id,level)
		game.first
	end

	def getGamePlayers(id,level)
		players=Game.where("championship_id=? and level=?",id,level)
	end
end

