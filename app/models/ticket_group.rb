class TicketGroup < ActiveRecord::Base
	has_many :tickets
	belongs_to :event
end
