# == Schema Information
#
# Table name: invoices
#
#  id          :integer         not null, primary key
#  sale_ids    :string(255)
#  customer_id :integer
#  total       :integer
#  user_id     :integer
#  on_site     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Invoice < ActiveRecord::Base
	has_many :sales, :dependent=>:destroy #is this right?
	belongs_to :seller, :class=>User, :foreign_key=>:user_id #seller
	has_one :buyer, :class=>User, :foreign_key=>:user_id #buyer
	
	validates :seller, :presence=>true
	
end
