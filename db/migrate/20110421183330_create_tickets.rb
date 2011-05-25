class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.belongs_to :event
      t.belongs_to :artist
      t.belongs_to :venue
      t.integer :quantity
      t.integer :cost
      t.text :bought_on
      t.text :in_hand
      t.text :type
      t.integer :sold
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
