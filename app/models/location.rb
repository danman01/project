class Location < ActiveRecord::Base
  
  has_many :users, :through=> :locations_users
  has_many :locations_users
  has_one :address
  
end
