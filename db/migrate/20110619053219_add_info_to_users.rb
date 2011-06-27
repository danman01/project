class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :region, :string
    add_column :users, :country, :string
    add_column :users, :phone, :string
    add_column :users, :notes, :string
  end

  def self.down
    remove_column :users, :notes
    remove_column :users, :phone
    remove_column :users, :country
    remove_column :users, :region
    remove_column :users, :city
    remove_column :users, :street
  end
end
