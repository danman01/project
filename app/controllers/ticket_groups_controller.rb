class TicketGroupsController < ApplicationController
  
  def show
    @ticket_group=TicketGroup.find(params[:id])
    @tickets=@ticket_group.tickets
  end
  
  def new
    
  end
  
  def edit
    
  end
  
  def destroy
    
  end

end
