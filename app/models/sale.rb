class Sale < ActiveRecord::Base
	belongs_to :ticket
	belongs_to :marketplace
	has_many :tickets
end
