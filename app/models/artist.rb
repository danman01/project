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
#

class Artist < ActiveRecord::Base
	has_many :tickets
	has_many :events
	has_many :venues, :through=>:events
end
