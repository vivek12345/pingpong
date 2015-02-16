class Player < ActiveRecord::Base
  attr_accessible :name, :password, :role, :defence_set_length
  has_secure_password
end
