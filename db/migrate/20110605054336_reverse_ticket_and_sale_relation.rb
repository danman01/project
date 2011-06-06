class ReverseTicketAndSaleRelation < ActiveRecord::Migration
  def self.up
	rename_column :sales, :ticket_id, :ticket_ids
        add_column :tickets, :sale_id, :integer
  end

  def self.down
	remove_column :tickets, :sale_id
	rename_column :sales, :ticket_ids, :ticket_id
  end
end
