class ChangeInvoiceIdTypeToInt < ActiveRecord::Migration
  def self.up
    change_column :sales, :invoice_id, :integer
  end

  def self.down
    change_column :sales, :invoice_id, :string
  end
end
