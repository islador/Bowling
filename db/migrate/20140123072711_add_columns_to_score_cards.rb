class AddColumnsToScoreCards < ActiveRecord::Migration
  def up
  	add_column :score_cards, :frame_1, :integer
  	add_column :score_cards, :frame_2, :integer
  	add_column :score_cards, :frame_3, :integer
  	add_column :score_cards, :frame_4, :integer
  	add_column :score_cards, :frame_5, :integer
  	add_column :score_cards, :frame_6, :integer
  	add_column :score_cards, :frame_7, :integer
  	add_column :score_cards, :frame_8, :integer
  	add_column :score_cards, :frame_9, :integer
  	add_column :score_cards, :frame_10, :integer
  end

  def down
  	remove_column :score_cards, :frame_1, :integer
  	remove_column :score_cards, :frame_2, :integer
  	remove_column :score_cards, :frame_3, :integer
  	remove_column :score_cards, :frame_4, :integer
  	remove_column :score_cards, :frame_5, :integer
  	remove_column :score_cards, :frame_6, :integer
  	remove_column :score_cards, :frame_7, :integer
  	remove_column :score_cards, :frame_8, :integer
  	remove_column :score_cards, :frame_9, :integer
  	remove_column :score_cards, :frame_10, :integer
  end
end
