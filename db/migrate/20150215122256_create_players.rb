class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :password_digest
      t.string :role
      t.integer :defence_set_length

      t.timestamps
    end
  end
end
