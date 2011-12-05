class Rating < ActiveRecord::Base
  
  belongs_to :seller, :class_name=>"User", :foreign_key => "seller_id"
  belongs_to :buyer, :class_name=>"User", :foreign_key => :buyer_id
  belongs_to :sale
  
  TRANS_RATING = {0 => "Positive", 1 => "Neutral", 2=> "Negative", 3=>"I'll leave feedback later"}
  
  named_scope :positive, :conditions => {:trans_rating=>0}
  named_scope :neutral, :conditions => {:trans_rating=>1}
  named_scope :negative, :conditions => {:trans_rating=>2}

  # t.integer :trans_rating
  # t.string :trans_notes
  # t.integer :accuracy
  # t.integer :communication
  # t.integer :cost
  # t.integer :seller_id
  # t.integer :buyer_id
  # t.integer :sale_id
end
