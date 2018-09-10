class TableOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders
    add_column :orders, :product_id, :integer
    add_index :orders, :product_id
    add_column :orders, :quantity, :integer
  end
end
