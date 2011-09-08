class AddAddressToVenue < ActiveRecord::Migration
  def self.up
    add_column :venues, :address, :string
  end

  def self.down
    remove_column :venues, :address
  end
end
