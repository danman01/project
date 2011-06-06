class AddEventIdToTicketGroups < ActiveRecord::Migration
  def self.up
  change_table :ticket_groups do |t|
    t.belongs_to :event
  end
  end

  def self.down
  remove_column :ticket_groups, :event_id
  end
end
