class AddCompleteToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :complete, :boolean, :default=>false
  end

  def self.down
    remove_column :users, :complete
  end
end
