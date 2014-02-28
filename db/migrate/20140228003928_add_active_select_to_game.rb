class AddActiveSelectToGame < ActiveRecord::Migration
  def up
  	add_column :games, :active_select, :integer
  end
  def down
  	remove_column :games, :active_select, :integer
  end
end
