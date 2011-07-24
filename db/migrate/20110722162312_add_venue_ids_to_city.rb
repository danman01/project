class AddVenueIdsToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :venue_ids, :string
  end

  def self.down
    remove_column :cities, :venue_ids
  end
end
