class ChangeFksToIds < ActiveRecord::Migration
  def self.up
	change_table :events do |t|
		t.remove :venue
		t.belongs_to :artist
		t.belongs_to :venue
 	end
  end

  def self.down
  end
end
