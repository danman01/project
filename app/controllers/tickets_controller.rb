class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.xml
  def index
    groups=[]
    @ticket_groups=[]
    if params[:event_id]
    @tickets = Ticket.find_all_by_event_id(params[:event_id])
    
      for ticket in @tickets
        groups<<ticket.ticket_group
       
      end
      @ticket_groups=groups.uniq!
    else
    @tickets=Ticket.all 
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
    
    if params[:event_id]
      if params[:ticket_group]
        @ticket.ticket_group=params[:ticket_group]
      end
    @ticket = Ticket.new
    @ticket.event=Event.find(params[:event_id]) 
    
    @ticket_groups=TicketGroup.find_all_by_event_id(@ticket.event.id)
    more=Ticket.find_all_by_event_id(@ticket.event.id)
  
    more.each do |ticket|
       @ticket_groups<<ticket.ticket_group
    end
    @ticket_groups.uniq!
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
    else
      respond_to do |format|
        format.html {redirect_to new_event_path, :notice=>'first create the event'}
      end
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
    @ticket = Ticket.new(params[:ticket])
    #create new ticket for each seat - @ticket is ticket 0, so start with 1
    seats=params[:ticket][:seat_number].split(",")
    n=seats.size
    c=1
    while c < n
      t=Ticket.new(params[:ticket])
      t.seat_number=seats[c]
      t.ticket_group=@ticket.ticket_group
      t.save
      c+=1
    end 
    respond_to do |format|
      if @ticket.save
        if @ticket.sold==1
          format.html { redirect_to new_sale_path(:ticket_id=>@ticket.id), :notice => 'Ticket was successfully created. Now fill in sale info' }
          format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
        else
          format.html { redirect_to(@ticket, :notice => 'Ticket was successfully created.') }
          format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
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
