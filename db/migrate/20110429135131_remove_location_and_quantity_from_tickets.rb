class RemoveLocationAndQuantityFromTickets < ActiveRecord::Migration
  def self.up
	change_table :tickets do |t|
		t.remove :location
		t.remove :quantity
	end
  end

  def self.down
	add_column :tickets, :location, :text
	add_column :tickets, :quantity, :integer
  end
end
