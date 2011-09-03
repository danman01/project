class ChangeSeatNumberToString < ActiveRecord::Migration
  def self.up
    change_column :tickets, :seat_number, :string
  end

  def self.down
    change_column :tickets, :seat_number, :integer
  end
end
