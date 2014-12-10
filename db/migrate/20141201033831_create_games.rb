class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :finished, null: false, default: false
      t.integer :player_1_id, null: false
      t.integer :player_2_id
      t.timestamps
    end
  end
end
