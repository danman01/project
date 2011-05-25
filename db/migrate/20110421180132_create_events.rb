class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.text :name
      t.text  :date
      t.text :venue
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
