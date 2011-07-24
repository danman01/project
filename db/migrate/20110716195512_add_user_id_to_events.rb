class AddUserIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :user_id, :integer
    add_column :events, :public, :integer, :default=>1
  end

  def self.down
    remove_column :event, :public
    remove_column :event, :user_id
  end
end
