# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_and_belongs_to_many :beta_signups
    
    AVAILABLE_ROLES = {2 => "I'm a fan and want to buy tickets", 5=> "I'm a fan and want to sell tickets", 4 => "I work with a venue, promotion company, or ticket company" }
end
