class TicketGroupsController < ApplicationController
  
  def show
    @ticket_group=TicketGroup.find(params[:id])
    @tickets=@ticket_group.tickets
  end
  
  def new
    @ticket_group=TicketGroup.new
    @event_id=params[:event_id]
    if params[:redirect]
   session[:redirect]=true
    end
     respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @ticket_group }
      end
  end
  
  def edit
    
  end
  
  def destroy
    
  end
  
  def create
    @group = TicketGroup.new(params[:ticket_group])
     event=Event.find(params[:event_id])
     @group.event=event
     artist=event.artist
     venue=event.venue
    respond_to do |format|
      if @group.save
        if session[:redirect]
            redirect="/tickets/new?artist_id#{artist.id}&venue_id=#{venue.id}&event_id=#{event.id}"
            session[:redirect]=nil
            format.html { redirect_to(redirect, :notice => 'group was successfully created.') }
        else
        format.html { redirect_to(@group, :notice => 'group was successfully created.') }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def select
    event_id=params[:event_id]
    @ticket_groups=[]
    tickets=Ticket.find_all_by_event_id(event_id)
    tickets.each do |t|
      @ticket_groups<<t.ticket_group
    end
    @ticket_groups.uniq!
  end
  
  def use_selected
    params.each do |param|
    flash[:notice]=param
    end
  end
end
