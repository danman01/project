class CreateTicketGroups < ActiveRecord::Migration
  def self.up
	create_table :ticket_groups do |g|
		g.text :section
		g.text :row
		g.integer :quantity
	end
  end

  def self.down
  	drop_table :ticket_groups
  end
end
