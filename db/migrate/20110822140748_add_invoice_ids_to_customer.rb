class AddInvoiceIdsToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :invoice_ids, :string
  end

  def self.down
    remove_column :customers, :invoice_ids, :string
  end
end
