class AddStateToVenue < ActiveRecord::Migration
  def self.up
	add_column :venues, :state, :text
  end

  def self.down
	remove_column :venues, :state
  end
end
