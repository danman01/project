class CreateMarketplaces < ActiveRecord::Migration
  def self.up
    create_table :marketplaces do |t|
      t.text :name
      t.integer :commission
      t.text :abbr

      t.timestamps
    end
  end

  def self.down
    drop_table :marketplaces
  end
end
