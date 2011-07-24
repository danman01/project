class Country < ActiveRecord::Base
  has_many :regions
  has_many :cities
  has_many :venues
end
