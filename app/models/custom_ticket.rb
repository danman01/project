class CustomTicket < ActiveRecord::Base
  belongs_to :custom_event
  belongs_to :seller, :class_name=>"User", :foreign_key =>"seller_id"  
  belongs_to :ticket_group
  belongs_to :sale
  
  validates_presence_of :ticket_group_id
  validates_presence_of :cost
  #validates_presence_of :seat_number
end
