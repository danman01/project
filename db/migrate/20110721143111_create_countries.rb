class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :country_code
      t.float :b_box_north
      t.float :b_box_south
      t.float  :b_box_east
      t.float  :b_box_west
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
