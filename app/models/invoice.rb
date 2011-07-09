# == Schema Information
#
# Table name: invoices
#
#  id          :integer         not null, primary key
#  sales_ids   :string(255)
#  customer_id :integer
#  total       :integer
#  user_id     :integer
#  on_site     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Invoice < ActiveRecord::Base
	has_many :sales, :dependent=>:destroy
	belongs_to :user #seller
	belongs_to :customer #buyer
end
