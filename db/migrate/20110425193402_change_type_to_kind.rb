class ChangeTypeToKind < ActiveRecord::Migration
  def self.up
 	rename_column :tickets, :type, :kind
  end

  def self.down
 
  end
end
