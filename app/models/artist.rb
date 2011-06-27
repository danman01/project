class Artist < ActiveRecord::Base
	has_many :tickets
	has_many :events
	has_many :venues, :through=>:events
end
