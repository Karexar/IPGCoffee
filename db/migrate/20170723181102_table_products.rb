class TableProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products
    add_column :products, :name, :string
    add_column :products, :price, :float
  end
end
