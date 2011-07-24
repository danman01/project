class CreateTours < ActiveRecord::Migration
  def self.up
    create_table :tours do |t|
      t.integer :artist_id
      t.string :event_ids

      t.timestamps
    end
  end

  def self.down
    drop_table :tours
  end
end
