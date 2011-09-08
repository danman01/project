# == Schema Information
#
# Table name: sales
#
#  id                :integer         not null, primary key
#  date              :datetime
#  price             :integer
#  quantity          :integer
#  notes             :text
#  created_at        :datetime
#  updated_at        :datetime
#  ticket_ids        :string(255)
#  marketplace_id    :integer
#  order_id          :string(255)
#  shipping          :integer
#  shipping_kind     :string(255)
#  handling          :integer
#  invoice_id        :string(255)
#  ticket_group_id   :integer
#  paypal_payment_id :string(255)
#

class Sale < ActiveRecord::Base
	belongs_to :marketplace
	has_many :tickets
	has_one :ticket_group
	belongs_to :invoice
end
