class Ticket < ActiveRecord::Base
	belongs_to :venue
	belongs_to :event
	belongs_to :artist
	belongs_to :ticket_group
	accepts_nested_attributes_for :ticket_group, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
