class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.string :username

      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      t.boolean :admin, default: false

      t.timestamps
    end

    add_index :users, :email
  end
end
