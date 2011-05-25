class AddFksToSales < ActiveRecord::Migration
  def self.up
 	 change_table :sales do |s|
		s.remove :ticket
		s.remove :marketplace
		s.references :ticket
		s.references :marketplace
  	 end
  end

  def self.down
  end
end
