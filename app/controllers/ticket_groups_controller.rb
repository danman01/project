class TicketGroupsController < ApplicationController
  load_and_authorize_resource
  def show
    @ticket_group=TicketGroup.find(params[:id])
    @tickets=@ticket_group.tickets
  end
  
  def new
    @ticket_group=TicketGroup.new
    @event_id=params[:event_id]
    @custom_event_id=params[:custom_event_id]
    # TODO change for normal app
    #if params[:redirect]
    #session[:redirect]=true
    end
     respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @ticket_group }
      end
  end
  
  def edit_tickets
      @group=TicketGroup.find(params[:ticket_group_id])
      tmp=@group.tickets
      @tickets=[]
      for each in tmp
        @tickets<<each.user_id==current_user.id
      end
      event_id=@ticket.event_id
      @ticket_groups=[]
      tickets=Ticket.find_all_by_event_id(event_id)
      tickets.each do |t|
        @ticket_groups<<t.ticket_group
      end
      @ticket_groups.uniq!
  end
  
  def edit
    
  end
  
  def destroy
    
  end
  
  def create
    @group = TicketGroup.new(params[:ticket_group])
    if params[:event_id]
     event=Event.find(params[:event_id])
     @group.event=event
      artist=event.artist
      venue=event.venue
      if session[:redirect]
          redirect="/tickets/new?artist_id#{artist.id}&venue_id=#{venue.id}&event_id=#{event.id}"
      end
    elsif params[:custom_event_id]
      event=CustomEvent.find(params[:custom_event_id])
       @group.custom_event=event
        if session[:redirect]
          redirect="/custom_tickets/new?custom_event_id=#{event.id}"
        end
    end
    respond_to do |format|
      if @group.save
        if redirect
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
