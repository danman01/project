# == Schema Information
#
# Table name: countries
#
#  id           :integer         not null, primary key
#  country_code :string(255)
#  b_box_north  :float
#  b_box_south  :float
#  b_box_east   :float
#  b_box_west   :float
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  status       :integer         default(1)
#

class Country < ActiveRecord::Base
  has_many :regions
  has_many :cities
  has_many :venues
  has_many :addresses
end
