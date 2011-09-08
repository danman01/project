class AddSaleIdToTicketGroup < ActiveRecord::Migration
  def self.up
    add_column :ticket_groups, :sale_id, :integer
  end

  def self.down
    remove_column :ticket_groups, :sale_id
  end
end
