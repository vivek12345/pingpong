class ChampionshipPlayer < ActiveRecord::Base
  attr_accessible :player_id
  belongs_to :championship
end
