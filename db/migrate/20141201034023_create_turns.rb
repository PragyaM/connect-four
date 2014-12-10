class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :lane_number, null: false
      t.integer :user_id, null: false
      t.integer :game_id, null: false
      t.timestamps
    end
  end
end
