class AddLocToTicket < ActiveRecord::Migration
  def self.up
  	add_column :tickets, :location, :text
  end

  def self.down
  	remove_volumn :tickets, :location
  end
end
