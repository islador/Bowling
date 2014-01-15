class CreateScoreCards < ActiveRecord::Migration
  def change
    create_table :score_cards do |t|
      t.integer :throw1
      t.integer :throw2
      t.integer :throw3
      t.integer :throw4
      t.integer :throw5
      t.integer :throw6
      t.integer :throw7
      t.integer :throw8
      t.integer :throw9
      t.integer :throw10
      t.integer :throw11
      t.integer :throw12
      t.integer :throw13
      t.integer :throw14
      t.integer :throw15
      t.integer :throw16
      t.integer :throw17
      t.integer :throw18
      t.integer :throw19
      t.integer :throw20
      t.integer :throw21
      t.integer :total
      t.integer :player_id

      t.timestamps
    end
  end
end
