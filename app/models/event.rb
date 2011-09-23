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
#  user_id    :integer
#  public     :integer         default(1)
#  status     :integer         default(1)
#  created_by :integer
#

class Event < ActiveRecord::Base
	belongs_to :venue
	belongs_to :artist
	has_many :tickets
	has_many :ticket_groups
	belongs_to :user
	
	validates :name, :presence=>true, :uniqueness=>true
	
	define_index do
	  #fields
	  indexes name, :sortable =>true
	  #attribtues
	  has created_at, updated_at, artist_id, venue_id, date
	end
	
	def to_param
      "#{id}-#{name.gsub(/[^a-z1-9]+/i, '-')}"
   end
   
   def upcoming
     if self.date>Time.now
       return self
     end
   end
end
