class DropUsers < ActiveRecord::Migration[5.1]
  def change
    drop_table :admins do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
    end
  end
end
