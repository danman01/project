class Event < ActiveRecord::Base
	belongs_to :venue
	belongs_to :artist
	has_many :tickets
	has_many :ticket_groups
	
	validates :name, :presence=>true, :uniqueness=>true
end
