# == Schema Information
#
# Table name: cities
#
#  id          :integer         not null, primary key
#  region_id   :integer
#  country_id  :integer
#  lat         :float
#  lng         :float
#  b_box_north :float
#  b_box_south :float
#  b_box_east  :float
#  b_box_west  :float
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  pop         :integer
#  venue_ids   :string(255)
#  status      :integer         default(1)
#  geonamesid  :integer
#

class City < ActiveRecord::Base
  belongs_to :region
  belongs_to :country
  has_many :venues
  
  define_index do
	  #fields
	  indexes name, :sortable =>true
	  #attribtues
	  has pop
	end
end
