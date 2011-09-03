class ChangeOnTourToOnTourUntil < ActiveRecord::Migration
  20110626174034_change_on_tour_to_on_tour_until.rb
  def self.up
	remove_column :artists, :on_tour_until
	add_column :artists, :on_tour_until, :datetime
  end

  def self.down
	add_column :artists, :on_tour_until, :integer
	remove_column :artists, :on_tour_until
  end
end
