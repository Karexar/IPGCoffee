class TableAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins
    add_column :admins, :name, :string
    add_column :admins, :password_digest, :string
  end
end
