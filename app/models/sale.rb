class Sale < ActiveRecord::Base
	belongs_to :marketplace
	has_many :tickets
	belongs_to :invoice
end
