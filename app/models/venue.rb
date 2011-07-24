# == Schema Information
#
# Table name: venues
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  capacity   :integer
#  url        :text
#  created_at :datetime
#  updated_at :datetime
#  state      :text
#  city       :string(255)
#  region     :string(255)
#  country    :string(255)
#  latitude   :string(255)
#  longitude  :string(255)
#  skid       :integer
#

class Venue < ActiveRecord::Base
	has_many :events
	has_many :tickets
	has_many :artists, :through=>:events
	belongs_to :city
	belongs_to :region
	belongs_to :country
end
