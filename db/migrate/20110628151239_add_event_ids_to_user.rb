class AddEventIdsToUser < ActiveRecord::Migration
  def self.up
	add_column :users, :event_ids, :string
  end

  def self.down
	remove_column :users, :event_ids, :string
  end
end
