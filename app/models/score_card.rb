# == Schema Information
#
# Table name: score_cards
#
#  id         :integer          not null, primary key
#  throw1     :integer
#  throw2     :integer
#  throw3     :integer
#  throw4     :integer
#  throw5     :integer
#  throw6     :integer
#  throw7     :integer
#  throw8     :integer
#  throw9     :integer
#  throw10    :integer
#  throw11    :integer
#  throw12    :integer
#  throw13    :integer
#  throw14    :integer
#  throw15    :integer
#  throw16    :integer
#  throw17    :integer
#  throw18    :integer
#  throw19    :integer
#  throw20    :integer
#  throw21    :integer
#  total      :integer
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  frame_1    :integer
#  frame_2    :integer
#  frame_3    :integer
#  frame_4    :integer
#  frame_5    :integer
#  frame_6    :integer
#  frame_7    :integer
#  frame_8    :integer
#  frame_9    :integer
#  frame_10   :integer
#

class ScoreCard < ActiveRecord::Base
  attr_accessible :player_id, :throw1, :throw10, :throw11, :throw12, :throw13, :throw14, :throw15, :throw16, :throw17, :throw18, :throw19, :throw2, :throw20, :throw21, :throw3, :throw4, :throw5, :throw6, :throw7, :throw8, :throw9, :total, :frame_1, :frame_2, :frame_3, :frame_4, :frame_5, :frame_6, :frame_7, :frame_8, :frame_9, :frame_10

  belongs_to :player

  after_create :default_values

  validates :player_id, presence: true


  def default_values
    self.total = 0
    self.frame_1 = 0
    self.frame_2 = 0
    self.frame_3 = 0
    self.frame_4 = 0
    self.frame_5 = 0
    self.frame_6 = 0
    self.frame_7 = 0
    self.frame_8 = 0
    self.frame_9 = 0
    self.frame_10 = 0
    self.save
  end
end
