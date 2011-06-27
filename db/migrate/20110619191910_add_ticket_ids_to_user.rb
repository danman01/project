class AddTicketIdsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ticket_ids, :string
  end

  def self.down
    remove_column :users, :ticket_ids
  end
end
