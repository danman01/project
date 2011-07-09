# == Schema Information
#
# Table name: events
#
#  id         :integer         not null, primary key
#  name       :text
#  date       :datetime
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#  artist_id  :integer
#  venue_id   :integer
#  time       :datetime
#

class Event < ActiveRecord::Base
	belongs_to :venue
	belongs_to :artist
	has_many :tickets
	has_many :ticket_groups
	
	validates :name, :presence=>true, :uniqueness=>true
end
