class AddCustomEventIdToTicketAndTicketGroup < ActiveRecord::Migration
  def self.up
    add_column :ticket_groups, :custom_event_id, :integer
    add_column :tickets, :custom_event_id, :integer
    
  end

  def self.down
    remove_column :tickets, :custom_event_id
    remove_column :ticket_groups, :custom_event_id
    
  end
end
