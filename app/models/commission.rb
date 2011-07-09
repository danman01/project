class Commission < ActiveRecord::Base
  belongs_to :user
  belongs_to :marketplace
end