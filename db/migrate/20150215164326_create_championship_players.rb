class CreateChampionshipPlayers < ActiveRecord::Migration
  def change
    create_table :championship_players do |t|

      t.integer :championship_id
      t.integer :player_id 	
      
      t.timestamps
    end
  end
end
