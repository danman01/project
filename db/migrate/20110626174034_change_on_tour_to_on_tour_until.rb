class ChangeOnTourToOnTourUntil < ActiveRecord::Migration
  def self.up
	remove_column :artists, :on_tour_until
	add_column :artists, :on_tour_until, :datetime
  end

  def self.down
	add_column :artists, :on_tour_until, :integer
	remove_column :artists, :on_tour_until
  end
end
