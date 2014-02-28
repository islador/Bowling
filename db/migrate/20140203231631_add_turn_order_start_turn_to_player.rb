class AddTurnOrderStartTurnToPlayer < ActiveRecord::Migration
  def up
  	add_column :players, :turn_order, :integer
  	add_column :players, :start_turn, :integer
  end

  def down
  	remove_column :players, :turn_order, :integer
  	remove_column :players, :start_turn, :integer
  end
end
