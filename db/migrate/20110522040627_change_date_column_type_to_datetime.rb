class ChangeDateColumnTypeToDatetime < ActiveRecord::Migration
  def self.up
    remove_column :sales, :date
    add_column :sales, :date, :datetime
  end

  def self.down
  end
end
