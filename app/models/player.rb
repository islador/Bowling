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
#  turn_order :integer
#  start_turn :integer
#

class Player < ActiveRecord::Base
  attr_accessible :name, :team, :turn_order, :start_turn

  has_one :score_card
  belongs_to :game

  after_save :create_score_card

  validates :name, presence: true
  validates :team, presence: true
  validates :game, presence: true

  #should validate turn order and start turn. This requires abstracting turn_order/start_turn logic to the model.
  #validates :turn_order, presence: true
  #validates :start_turn, presence: true

end
