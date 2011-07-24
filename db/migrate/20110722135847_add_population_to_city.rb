class AddPopulationToCity < ActiveRecord::Migration
  def self.up
    add_column :cities, :pop, :integer
  end

  def self.down
    remove_column :cities, :pop
  end
end
