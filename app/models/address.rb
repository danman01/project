class Address < ActiveRecord::Base
  
  belongs_to :location
  has_many :users, :through=> :addresses_users
  has_many :addresses_users
  belongs_to :city, :region, :country, :zip
end
