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
#  seat_number     :string(255)
#  sale_id         :integer
#  user_id         :integer
#  list            :float
#

class Ticket < ActiveRecord::Base
	belongs_to :venue
	belongs_to :event
	belongs_to :custom_event
	belongs_to :artist
	belongs_to :ticket_group
	belongs_to :sale
	belongs_to :user #seller
	belongs_to :seller
	belongs_to :venue
	accepts_nested_attributes_for :ticket_group, :allow_destroy => :true,
      :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  #validates_presence_of :seat_number, :ticket_group, :cost
  #TODO fix for normal events
  #validates_presence_of :event_id, :artist_id, :venue_id, :user_id, :unless=> :is_custom_event
  validates_presence_of :custom_event_id #, :unless => :is_normal_event
  
  attr_accessor :custom_event_id, :seller_id
  
  def is_custom_event
    if self.custom_event
      true
    else
      false
    end
  end
  
  def is_normal_event
    if self.event
      true
    else
      false
    end
  end
  def is_sold?
    if self.sold==1
    return self
    end
  end
end
