class ChangeOnTourToOnTourUntil < ActiveRecord::Migration
  def self.up
	remove_column :artists, :onTour
	add_column :artists, :on_tour_until, :datetime
  end

  def self.down
	add_column :artists, :onTour, :integer
	remove_column :artists, :on_tour_until
  end
end
