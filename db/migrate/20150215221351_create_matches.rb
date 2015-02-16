class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
    	t.integer :game_id
    	t.integer :playing_first
    	t.integer :playing_second
    	t.integer :first_player_move
    	t.integer :second_player_move
    	t.integer :winner
      t.timestamps
    end
  end
end
