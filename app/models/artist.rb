# == Schema Information
#
# Table name: artists
#
#  id            :integer         not null, primary key
#  name          :text
#  url           :text
#  created_at    :datetime
#  updated_at    :datetime
#  mbid          :string(255)
#  eventsHref    :string(255)
#  on_tour_until :datetime
#  status        :integer         default(1)
#  skid          :string(255)
#

class Artist < ActiveRecord::Base
	has_many :tickets
	has_many :events
	has_many :venues, :through=>:events
	validates_uniqueness_of :name
	define_index do
	  #fields
	  indexes name, :sortable =>true
	  #attribtues
	  has created_at, updated_at
	end
end
