class DropAdmins < ActiveRecord::Migration[5.1]
  def change
    drop_table :admins do |t|
      t.string :name, password: false
      t.timestamps null: false
    end
  end
end
