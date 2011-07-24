class ChangeStateToRegion < ActiveRecord::Migration
  def self.up
    rename_column "venues", "state", "region_id"
  end

  def self.down
    rename_column "venues", "region_id", "state"
  end
end
