class Championship < ActiveRecord::Base
  attr_accessible :status
  has_many :championship_players
  has_many :games
end
