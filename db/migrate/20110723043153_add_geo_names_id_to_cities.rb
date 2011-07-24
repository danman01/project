class AddGeoNamesIdToCities < ActiveRecord::Migration
  def self.up
    add_column :cities, :geonamesid, :integer
  end

  def self.down
    remove_column :cities, :geonamesid
  end
end
