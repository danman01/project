class AddLevelAndAisleToTicketGroup < ActiveRecord::Migration
  def self.up
    add_column :ticket_groups, :level, :string
    add_column :ticket_groups, :aisle, :string
  end

  def self.down
    remove_column :ticket_groups, :aisle
    remove_column :ticket_groups, :level
  end
end
