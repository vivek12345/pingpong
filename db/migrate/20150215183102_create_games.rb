class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :championship_id
      t.integer :level
      t.integer :player1
      t.integer :player2
      t.string  :status
      t.integer :winner	
      t.timestamps
    end
  end
end
