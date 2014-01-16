# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  date       :date
#  start_time :time
#  end_time   :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ActiveRecord::Base
  attr_accessible :date, :end_time, :start_time

  has_many :players
  #has_many :scorecards, through: :players

  validates :date, presence: true
  validates :start_time, presence: true
end
