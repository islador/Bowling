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

  validates :name, presence: true
  validates :team, presence: true
  validates :game, presence: true
end
