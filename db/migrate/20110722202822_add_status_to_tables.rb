class AddStatusToTables < ActiveRecord::Migration
  def self.up
    add_column :cities, :status, :integer, :default=>1
    add_column :regions, :status, :integer, :default=>1
    add_column :countries, :status, :integer, :default=>1
    add_column :venues, :status, :integer, :default=>1
    add_column :artists, :status, :integer, :default=>1
    add_column :events, :status, :integer, :default=>1
  end

  def self.down
    remove_column :cities, :status
    remove_column :regions, :status
    
    remove_column :countries, :status
    remove_column :venues, :status
    remove_column :artists, :status
    remove_column :events, :status
    
    
  end
end
