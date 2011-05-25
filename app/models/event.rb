class Event < ActiveRecord::Base
	belongs_to :venue
	belongs_to :artist
	has_many :tickets
end
