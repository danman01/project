class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.integer :region_id
      t.integer :country_id
      t.float :lat
      t.float :lng
      t.float :b_box_north
      t.float :b_box_south
      t.float  :b_box_east
      t.float  :b_box_west
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
