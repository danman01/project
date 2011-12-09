class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :address_id
      t.string :notes
      t.string :name
      t.float :lat
      t.float :lng

      t.timestamps
    end
    
    add_index(:locations, :address_id)
    
  end

  def self.down
    drop_table :locations
  end
end
