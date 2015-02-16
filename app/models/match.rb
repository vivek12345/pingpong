class Match < ActiveRecord::Base
  attr_accessible :game_id, :playing_first, :playing_second, :first_player_move, :second_player_move, :winner
  belongs_to :game
end
