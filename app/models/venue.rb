# == Schema Information
#
# Table name: venues
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  capacity     :integer
#  url          :text
#  created_at   :datetime
#  updated_at   :datetime
#  region_name  :text
#  city_name    :string(255)
#  country_name :string(255)
#  latitude     :string(255)
#  longitude    :string(255)
#  skid         :integer
#  city_id      :integer
#  country_id   :integer
#  region_id    :integer
#  status       :integer         default(1)
#

class Venue < ActiveRecord::Base
	has_many :events
	has_many :tickets
	has_many :artists, :through=>:events
	belongs_to :city
	belongs_to :region
	belongs_to :country
end
