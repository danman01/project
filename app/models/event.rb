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
	belongs_to :user
	
	validates :name, :presence=>true, :uniqueness=>true
	
	def to_param
      "#{id}-#{name.gsub(/[^a-z1-9]+/i, '-')}"
   end
   
   def upcoming
     if self.date>Time.now
       return self
     end
   end
end
