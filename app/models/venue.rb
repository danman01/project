# == Schema Information
#
# Table name: venues
#
#  id             :integer         not null, primary key
#  name           :string(255)
#  capacity       :integer
#  url            :text
#  created_at     :datetime
#  updated_at     :datetime
#  region_name    :text
#  city_name      :string(255)
#  country_name   :string(255)
#  latitude       :float           default(0.0)
#  longitude      :float
#  skid           :integer
#  city_id        :integer
#  country_id     :integer
#  region_id      :integer
#  status         :integer         default(1)
#  capacity_notes :string(255)
#  address        :string(255)
#

class Venue < ActiveRecord::Base
	has_many :events
	has_many :tickets
	has_many :artists, :through=>:events
	belongs_to :city
	belongs_to :region
	belongs_to :country
	attr_accessible :latitude, :longitude, :address
	reverse_geocoded_by :latitude, :longitude #done when model is updated
	after_validation :geocode, :if=>:latitude_changed? #determins if different
	
	define_index do
	  #fields
	  indexes name, :sortable =>true
	  #attribtues
	  has capacity, country_id, created_at, updated_at
	end
end
