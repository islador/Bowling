class Player < ActiveRecord::Base
  attr_accessible :game_id, :name, :team
end
