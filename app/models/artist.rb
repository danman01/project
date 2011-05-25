class Artist < ActiveRecord::Base
	has_many :tickets
	has_many :events
end
