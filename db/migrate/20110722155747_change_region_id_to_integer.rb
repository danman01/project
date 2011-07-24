class ChangeRegionIdToInteger < ActiveRecord::Migration
  def self.up
    change_table "venues" do |v|
      v.rename :city, :city_name
      v.integer :city_id
      v.rename :country, :country_name
      v.integer :country_id
      v.rename :region_id, :region_name
      v.integer :region_id
    end
  end

  def self.down
    change_table "venues" do |v|
      v.rename :city_name, :city
      v.remove :city_id
      v.rename :country_name, :country
      v.remove :country_id
      v.rename :region_name, :region_id
      v.remove :region_id
    end
  end
end
