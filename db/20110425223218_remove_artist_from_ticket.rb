class RemoveArtistFromTicket < ActiveRecord::Migration
  def self.up
	remove_column :tickets, :artist
  end

  def self.down
  end
end
