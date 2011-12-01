class CreateBetaSignups < ActiveRecord::Migration
  def self.up
    create_table :beta_signups do |t|
      t.string :email
      t.string :name
      t.string :ip_address
      t.float :lat
      t.float :lng
      t.integer :region_id
      t.integer :city_id
      t.boolean :approved, :default=>false
      t.timestamps
    end
    
    create_table :beta_signups_roles, :id => false do |t|
      t.references :beta_signup, :role
    end
    
  end

  def self.down
    drop_table :beta_signups
  end
end
