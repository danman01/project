class HomeController < ApplicationController
  def index
    @invoices=current_user.invoices
    @invoices.reject!{|x|x.sales.empty?}
    @events=current_user.events
    @tickets=current_user.tickets
    @artists=[]
    @venues=[]
    @events.uniq!
    @events.each do |e|
      @artists<<e.artist
      @venues<<e.venue
    end
      @tickets=Ticket.find_all_by_user_id(current_user.id) 
      groups=[]
    for ticket in @tickets
      groups<<ticket.ticket_group
 
    end
    @ticket_groups=groups.uniq!
  end

end
