class ChangeSalesIdsToSaleIds < ActiveRecord::Migration
  def self.up
	rename_column :invoices, :sales_ids, :sale_ids
  end

  def self.down
	rename_column :invoices, :sale_ids, :sales_ids
  end
end
