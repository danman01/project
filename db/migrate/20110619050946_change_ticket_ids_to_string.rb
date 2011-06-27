class ChangeTicketIdsToString < ActiveRecord::Migration
  def self.up
	change_column :sales, :ticket_ids, :string
  end

  def self.down
  	change_column :sales, :ticket_ids, :integer
  end
end
