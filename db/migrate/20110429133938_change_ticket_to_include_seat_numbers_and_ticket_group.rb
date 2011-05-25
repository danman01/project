class ChangeTicketToIncludeSeatNumbersAndTicketGroup < ActiveRecord::Migration
  def self.up
	change_table :tickets do |t|
		t.belongs_to :ticket_group
	end
	
	add_column :tickets, :seat_number, :integer
  end

  def self.down
  	change_table :tickets do |t|
		t.remove_column :seat_number
		t.remove_column :ticket_group_id
	end
  end
end
