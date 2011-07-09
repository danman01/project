# == Schema Information
#
# Table name: marketplaces
#
#  id         :integer         not null, primary key
#  name       :text
#  commission :float
#  abbr       :text
#  created_at :datetime
#  updated_at :datetime
#

class Marketplace < ActiveRecord::Base
	has_many :sales
	has_many :commissions
end
