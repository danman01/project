class CreateAddressesUsers < ActiveRecord::Migration
  def self.up
    create_table :addresses_users do |t|
      t.integer :address_id
      t.integer :user_id
      t.boolean :current

      t.timestamps
    end
    add_index(:addresses_users, [:address_id, :user_id])
    
  end

  def self.down
    drop_table :addresses_users
  end
end
