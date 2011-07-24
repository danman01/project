class RemoveRegionFromVenue < ActiveRecord::Migration
  def self.up
    remove_column :venues,:region
  end

  def self.down
  end
end
