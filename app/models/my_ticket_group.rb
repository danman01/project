class MyTicketGroup < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :ticket_group
  
  def self.find_or_create(userid, groupid)
    if !find_my_ticket_group(userid, groupid)
    MyTicketGroup.new(:ticket_group_id=>groupid, :user_id=>userid, :quantity=>0)
   end
  end
  
  def find_my_ticket_group(userid, groupid)
    MyTicketGroup.find_by_user_id(userid, :conditions=>['ticket_group_id = ?', groupid])
  end
end
