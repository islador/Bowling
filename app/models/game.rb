class Game < ActiveRecord::Base
  attr_accessible :date, :end_time, :start_time
end
