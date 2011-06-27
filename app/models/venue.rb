class Venue < ActiveRecord::Base
	has_many :events
	has_many :tickets
	has_many :artists, :through=>:events
end
