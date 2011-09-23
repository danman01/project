# == Schema Information
#
# Table name: customers
#
#  id          :integer         not null, primary key
#  email       :string(255)
#  client_type :string(255)
#  street      :string(255)
#  city        :string(255)
#  region      :string(255)
#  phone       :string(255)
#  notes       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  fname       :string(255)
#  lname       :string(255)
#  invoice_ids :string(255)
#

class Customer < ActiveRecord::Base
	has_many :invoices
end
