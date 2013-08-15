class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :host
      t.integer :port

      t.timestamps
    end
  end
end
