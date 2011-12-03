# == Schema Information
#
# Table name: ticket_groups
#
#  id       :integer         not null, primary key
#  section  :text
#  row      :text
#  quantity :integer
#  event_id :integer
#  sale_id  :integer
#

class TicketGroup < ActiveRecord::Base
	has_many :tickets
	belongs_to :event
	belongs_to :custom_event
	has_many :custom_tickets
	belongs_to :sale
end
