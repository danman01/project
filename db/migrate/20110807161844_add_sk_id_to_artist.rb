class AddSkIdToArtist < ActiveRecord::Migration
  def self.up
    add_column :artists, :skid, :string
  end

  def self.down
    remove_column :artists, :skid
  end
end
