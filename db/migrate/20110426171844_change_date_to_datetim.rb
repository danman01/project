class ChangeDateToDatetim < ActiveRecord::Migration
  def self.up
    remove_column :events, :date
	add_column :events, :date, :datetime
	remove_column :tickets, :bought_on
	add_column :tickets, :bought_on, :datetime
  remove_column :tickets, :in_hand
	add_column :tickets, :in_hand, :datetime
  end

  def self.down
  end
end
