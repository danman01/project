class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :city_id
      t.integer :region_id
      t.integer :country_id
      t.integer :zip_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
    add_index(:addresses, :city_id)
    add_index(:addresses, :region_id)
    add_index(:addresses, :country_id)
    add_index(:addresses, :zip_id)
    
  end

  def self.down
    drop_table :addresses
  end
end
