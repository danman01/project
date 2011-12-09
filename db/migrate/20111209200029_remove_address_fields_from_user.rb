class RemoveAddressFieldsFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :street
    remove_column :users, :city
    remove_column :users, :region
    remove_column :users, :country
    
  end

  def self.down
  end
end
