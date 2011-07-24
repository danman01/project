class CreateIndexesOnFks < ActiveRecord::Migration
  def self.up
    add_index :cities, :name
    add_index :cities, :region_id
    add_index :cities, :country_id
    add_index :cities, :pop
    add_index :venues, :city_id
    add_index :venues, :country_id
    add_index :venues, :region_id
    add_index :regions, :country_id
    add_index :tickets, :event_id
    add_index :tickets, :user_id
    add_index :tickets, :artist_id
    add_index :ticket_groups, :event_id
    add_index :events, :venue_id
    add_index :events, :artist_id
  end

  def self.down
    remove_index :cities, :name
    remove_index :cities, :region_id
    remove_index :cities, :country_id
    remove_index :cities, :pop
    remove_index :venues, :city_id
    remove_index :venues, :country_id
    remove_index :venues, :region_id
    remove_index :regions, :country_id
    remove_index :tickets, :event_id
    remove_index :tickets, :user_id
    remove_index :tickets, :artist_id
    remove_index :ticket_groups, :event_id
    remove_index :events, :venue_id
    remove_index :events, :artist_id
  end
end
