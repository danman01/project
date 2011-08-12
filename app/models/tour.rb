# == Schema Information
#
# Table name: tours
#
#  id         :integer         not null, primary key
#  artist_id  :integer
#  event_ids  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tour < ActiveRecord::Base
end
