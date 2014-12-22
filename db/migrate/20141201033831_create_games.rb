class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :finished, null: false, default: false
      t.timestamps
    end
  end
end
