# == Schema Information
#
# Table name: tickets
#
#  id              :integer         not null, primary key
#  cost            :integer
#  bought_on       :datetime
#  in_hand         :datetime
#  kind            :text
#  sold            :integer
#  notes           :text
#  created_at      :datetime
#  updated_at      :datetime
#  event_id        :integer
#  artist_id       :integer
#  venue_id        :integer
#  ticket_group_id :integer
#  seat_number     :integer
#  sale_id         :integer
#  user_id         :integer
#  list            :float
#

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
  
  def is_sold?
    if self.sold==1
    return self
    end
  end
end
