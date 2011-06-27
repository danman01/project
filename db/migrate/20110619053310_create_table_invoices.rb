class CreateTableInvoices < ActiveRecord::Migration
  def self.up
	create_table :invoices do |i|
	i.string :sales_ids
	i.integer	:customer_id
	i.integer	:total
	i.integer	:user_id
	i.integer	:on_site
	i.timestamps
	end
  end

  def self.down
	drop_table :invoices
  end
end
