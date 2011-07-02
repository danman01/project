class TicketsController < ApplicationController
  respond_to :html, :js, :xml
  def index
    groups=[]
    @ticket_groups=[]
    if params[:event_id]
      if params[:user_id]
        @tickets = Ticket.find_all_by_event_id(params[:event_id], :conditions=>["user_id=?", params[:user_id]])
      else
        @tickets = Ticket.find_all_by_event_id(params[:event_id])
      end
    
      for ticket in @tickets
        groups<<ticket.ticket_group
       
      end
      @ticket_groups=groups.uniq!
    else
      if params[:user_id]
        @tickets=Ticket.find_all_by_user_id(params[:user_id]) 
      else
        @tickets=Ticket.all
      end
      for ticket in @tickets
        groups<<ticket.ticket_group
   
      end
      @ticket_groups=groups.uniq!
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }
    end
  end

  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new
    if params[:event_id]
      @ticket.event=Event.find(params[:event_id]) 
    
      if params[:ticket_group]
        @ticket.ticket_group=params[:ticket_group]
      end
    
        @ticket_groups=TicketGroup.find_all_by_event_id(@ticket.event.id)
        more=Ticket.find_all_by_event_id(@ticket.event.id)
        more.each do |ticket|
          @ticket_groups<<ticket.ticket_group
        end
        @ticket_groups.uniq!
      end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
   
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    
  end
  def select_group
    @event_id=params[:event_id]
    @groups=Event.find(@event_id)
  end
  # POST /tickets
  # POST /tickets.xml
  def create
    
    #create new ticket for each seat - @ticket is ticket 0, so start with 1
    q=params[:quantity].to_i
    n=0
    seats=params[:seats].split(",")
    @ticket_group=TicketGroup.find(params[:ticket][:ticket_group])
    if @ticket_group.quantity.nil? #initialize quantity
      @ticket_group.quantity=0
    end
    params[:ticket][:ticket_group]=@ticket_group
    while n < q 
      t=Ticket.new(params[:ticket])
      t.seat_number=seats[n]
      t.user_id=current_user.id rescue 1 #so i dont have to log in during testing
      t.save
      n+=1
      @ticket_group.quantity+=1
      logger.info 'ticket created! ' +n.to_s
    end 
    @ticket_group.save
    respond_with(@ticket_group)
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        format.html { redirect_to(@ticket, :notice => 'Ticket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url) }
      format.xml  { head :ok }
    end
  end
end
