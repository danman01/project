class City < ActiveRecord::Base
  belongs_to :region
  belongs_to :country
  has_many :venues
end
