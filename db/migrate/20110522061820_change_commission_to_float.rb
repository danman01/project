class ChangeCommissionToFloat < ActiveRecord::Migration
  def self.up
	change_column :marketplaces, :commission, :float
  end

  def self.down
  end
end
