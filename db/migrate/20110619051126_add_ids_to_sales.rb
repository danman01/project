class AddIdsToSales < ActiveRecord::Migration
  def self.up
    add_column :sales, :order_id, :string
       add_column :sales, :shipping, :integer
    add_column :sales, :shipping_kind, :string
    add_column :sales, :handling, :integer

    add_column :sales, :invoice_id, :string
  end

  def self.down
    remove_column :sales, :invoice_id
    remove_column :sales, :order_id
  end
end
