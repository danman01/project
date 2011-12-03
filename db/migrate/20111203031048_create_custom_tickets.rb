class CreateCustomTickets < ActiveRecord::Migration
  def self.up
    create_table :custom_tickets do |t|
      t.integer :custom_event_id
      t.integer :seller_id
      t.string :seat_number
      t.integer :cost
      t.integer :ticket_group_id
      t.boolean :sold
      t.boolean :list

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_tickets
  end
end
