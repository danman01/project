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
#  invoice_id        :integer
#  ticket_group_id   :integer
#  paypal_payment_id :string(255)
#

class Sale < ActiveRecord::Base
	belongs_to :marketplace
	has_many :tickets
	has_one :my_ticket_group
	belongs_to :invoice
  
  before_destroy :fix_tickets

  private

  def fix_tickets
    # on delete need to:
  	# increment ticket gorup appropriately
  	# remove sale_id from ticket(s)
  	# change sold to 0 for tickets
  	tickets=self.tickets
    
    size = tickets.size
    group=tickets.first.ticket_group
    mygroup = find_my_ticket_group(tickets.first.user_id, group.id)
    group.quantity+=size
    mygroup.quantity+=size
    mygroup.save
    group.save
    tickets.each do |t|
      t.sale_id=nil
      t.sold=0
      t.save
    end
  end
	
end
