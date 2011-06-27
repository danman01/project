class AddEventsHrefToArtists < ActiveRecord::Migration
  def self.up
    add_column :artists, :eventsHref, :string
  end

  def self.down
    remove_column :artists, :eventsHref
  end
end
