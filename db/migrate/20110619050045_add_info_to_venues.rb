class AddInfoToVenues < ActiveRecord::Migration
  def self.up
    add_column :venues, :city, :string
    add_column :venues, :region, :string
    add_column :venues, :country, :string
    add_column :venues, :latitude, :string
    add_column :venues, :longitude, :string
  end

  def self.down
    remove_column :venues, :longitude
    remove_column :venues, :latitude
    remove_column :venues, :country
    remove_column :venues, :region
    remove_column :venues, :city
  end
end
