class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :trans_rating
      t.string :trans_notes
      t.integer :accuracy
      t.integer :communication
      t.integer :cost
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :sale_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
