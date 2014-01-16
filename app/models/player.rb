# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  team       :integer
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base
  attr_accessible :name, :team

  has_one :score_card
  belongs_to :game

  after_save :create_score_card

  validates :name, presence: true
  validates :team, presence: true
  validates :game, presence: true

  #Creates a scorecard for itself
  def update_flight
  	self.create_score_card
  end
end
