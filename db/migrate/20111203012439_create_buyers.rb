class CreateBuyers < ActiveRecord::Migration
  def self.up
    create_table :buyers do |t|
      t.string :email
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :location
      t.float :lat
      t.float :lng
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :buyers
  end
end
