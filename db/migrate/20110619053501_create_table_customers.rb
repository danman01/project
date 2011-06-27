class CreateTableCustomers < ActiveRecord::Migration
  def self.up
	create_table :customers do |c|
	c.string	:email
	c.string	:client_type
	c.string	:street
	c.string	:city
	c.string	:region
	c.string	:phone
	c.string	:notes
	c.timestamps
	end
  end

  def self.down
	drop_table :customers
  end
end
