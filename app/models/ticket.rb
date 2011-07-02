class Ticket < ActiveRecord::Base
	belongs_to :venue
	belongs_to :event
	belongs_to :artist
	belongs_to :ticket_group
	belongs_to :sale
	belongs_to :user #seller
	belongs_to :venue
	accepts_nested_attributes_for :ticket_group, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
      
  validates_presence_of :seat_number, :ticket_group, :cost, :event_id, :artist_id, :venue_id, :user_id
  
end
