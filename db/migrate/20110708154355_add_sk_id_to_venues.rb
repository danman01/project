class AddSkIdToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :skid, :integer
  end

  def self.down
    remove_column :venues, :skid
  end
end
