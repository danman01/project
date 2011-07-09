class CreateTableCommissions < ActiveRecord::Migration
  def self.up
	create_table :commissions do |c|
	c.float :commission
	c.belongs_to :user
	c.belongs_to :marketplace
  
	end
  end
  def self.down
	drop_table :commissions
  end
end
