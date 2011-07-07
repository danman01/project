class AddFNameAndLNameToCustomer < ActiveRecord::Migration
  def self.up
    change_table :customers do |c|
	c.string :fname
    	c.string :lname
    end
  end

  def self.down
    remove_column :customers, :lname
    remove_column :customers, :fname
  end
end
