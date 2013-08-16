class AddMotdToGames < ActiveRecord::Migration
  def change
    add_column :games, :motd, :string
  end
end
