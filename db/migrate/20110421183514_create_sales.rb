class CreateSales < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.text :date
      t.integer :price
      t.integer :quantity
      t.integer :ticket
      t.text :notes
      t.text :marketplace
      t.timestamps
    end
  end

  def self.down
    drop_table :sales
  end
end
