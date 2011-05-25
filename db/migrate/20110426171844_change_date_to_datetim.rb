class ChangeDateToDatetim < ActiveRecord::Migration
  def self.up
	change_column :events, :date, :datetime
	change_column :tickets, :bought_on, :datetime
	change_column :tickets, :in_hand, :datetime
  end

  def self.down
  end
end
