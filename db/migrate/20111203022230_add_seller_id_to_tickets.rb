class AddSellerIdToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :seller_id, :integer
  end

  def self.down
    remove_column :tickets, :seller_id
  end
end
