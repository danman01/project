class ChangeDateColumnTypeToDatetime < ActiveRecord::Migration
  def self.up
    change_column :sales, :date, :datetime
  end

  def self.down
  end
end
