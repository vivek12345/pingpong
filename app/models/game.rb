class Game < ActiveRecord::Base
  attr_accessible :level, :status, :winner,:player1,:player2
  belongs_to :championship
  has_many :matches
end
