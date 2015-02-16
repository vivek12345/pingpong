class CreateChampionships < ActiveRecord::Migration
  def change
    create_table :championships do |t|
      t.string :status

      t.timestamps
    end
  end
end
