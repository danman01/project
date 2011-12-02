class CreateCustomEvents < ActiveRecord::Migration
  def self.up
    create_table :custom_events do |t|
      t.string :name
      t.datetime :date
      t.text :notes
      t.integer :user_id
      t.integer :scope
      t.integer :status
      t.integer :venue_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :custom_events
  end
end
