class AddCapacityNotesToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :capacity_notes, :string
  end

  def self.down
    remove_column :venues, :capacity_notes
  end
end
