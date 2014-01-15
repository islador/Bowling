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
#

class ScoreCard < ActiveRecord::Base
  attr_accessible :player_id, :throw1, :throw10, :throw11, :throw12, :throw13, :throw14, :throw15, :throw16, :throw17, :throw18, :throw19, :throw2, :throw20, :throw21, :throw3, :throw4, :throw5, :throw6, :throw7, :throw8, :throw9, :total
end
