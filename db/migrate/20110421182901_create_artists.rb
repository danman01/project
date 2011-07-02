class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.text :name
      t.text :url
      t.integer :on_tour_until

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
