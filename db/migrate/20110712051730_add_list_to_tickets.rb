class AddListToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :list, :float
  end

  def self.down
    remove_column :tickets, :list
  end
end
