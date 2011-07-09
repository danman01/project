# == Schema Information
#
# Table name: ticket_groups
#
#  id       :integer         not null, primary key
#  section  :text
#  row      :text
#  quantity :integer
#  event_id :integer
#

class TicketGroup < ActiveRecord::Base
	has_many :tickets
	belongs_to :event
end
