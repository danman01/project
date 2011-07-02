class AddTicketGroupIdToSales < ActiveRecord::Migration
  def self.up
	add_column :sales, :ticket_group_id, :integer
  end

  def self.down
	remove_column :sales, :ticket_group_id
  end
end
