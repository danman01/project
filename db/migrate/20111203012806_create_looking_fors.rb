class CreateLookingFors < ActiveRecord::Migration
  def self.up
    create_table :looking_fors do |t|
      t.integer :event_id
      t.integer :custom_event_id
      t.integer :buyer_id
      t.integer :user_id
      t.integer :price
      t.integer :quantity
      t.string :section
      t.string :row
      t.string :level

      t.timestamps
    end
  end

  def self.down
    drop_table :looking_fors
  end
end
