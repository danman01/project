class CustomTicket < ActiveRecord::Base
  belongs_to :custom_event
  belongs_to :seller
  belongs_to :ticket_group
end
