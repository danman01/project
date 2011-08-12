# == Schema Information
#
# Table name: regions
#
#  id          :integer         not null, primary key
#  country_id  :integer
#  b_box_north :float
#  b_box_south :float
#  b_box_east  :float
#  b_box_west  :float
#  name        :string(255)
#  region_code :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  status      :integer         default(1)
#

class Region < ActiveRecord::Base
  belongs_to :country
  has_many :cities
  has_many :venues
end
