class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, null: false, default: "Nigel No-Name"
      t.timestamps
    end
  end
end
