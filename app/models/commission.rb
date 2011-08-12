# == Schema Information
#
# Table name: commissions
#
#  id             :integer         not null, primary key
#  commission     :float
#  user_id        :integer
#  marketplace_id :integer
#

class Commission < ActiveRecord::Base
  belongs_to :user
  belongs_to :marketplace
  
end
