class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.integer :country_id
      t.float :b_box_north
      t.float :b_box_south
      t.float  :b_box_east
      t.float  :b_box_west
      t.string :name
      t.string :region_code

      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
