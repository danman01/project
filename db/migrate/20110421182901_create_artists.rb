class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.text :name
      t.text :url
      t.integer :onTour

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
