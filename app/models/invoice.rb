class Invoice < ActiveRecord::Base
	has_many :sales, :dependent=>:destroy
	belongs_to :user #seller
	belongs_to :customer #buyer
end
