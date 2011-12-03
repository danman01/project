class CustomTicket < ActiveRecord::Base
  belongs_to :custom_event
  belongs_to :seller
  belongs_to :ticket_group
  
  validates_presence_of :ticket_group_id
  validates_presence_of :cost
  #validates_presence_of :seat_number
end
