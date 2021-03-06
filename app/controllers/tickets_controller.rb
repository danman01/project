class TicketsController < ApplicationController
  respond_to :html, :js, :xml
  load_and_authorize_resource
  layout 'beta', :only=>['beta_sell']
  layout 'application', :except=>['beta_sell']
  def beta_sell
    #from custom_event
      @ticket = Ticket.new
      if params[:custom_event_id]
        @ticket.custom_event=CustomEvent.find(params[:custom_event_id]) 

        if params[:ticket_group]
          @ticket.ticket_group=params[:ticket_group]
        end

          @ticket_groups=TicketGroup.find_all_by_custom_event_id(@ticket.custom_event.id)
          more=Ticket.find_all_by_custom_event_id(@ticket.custom_event.id)
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
  
  def create
    
    #create new ticket for each seat - @ticket is ticket 0, so start with 1
    q=params[:quantity].to_i
    n=0
    seats=params[:seats].split(",")
    
    session[:seller].blank? ? userid=current_user.id : userid = session[:seller]
     @ticket_group=TicketGroup.find(params[:ticket][:ticket_group_id])
    @mygroup = MyTicketGroup.find_or_create(userid, @ticket_group.id) 
    if @ticket_group.quantity.nil? #initialize quantity
      @ticket_group.quantity=0
    end
    #params[:ticket][:ticket_group]=@ticket_group
    while n < q 
      @t=Ticket.new(params[:ticket])
      if params[:custom_event_id]
      @seller=Seller.find(params[:ticket][:seller_id])
      params[:ticket][:seller]=@seller
              @t.custom_event_id=CustomEvent.find(params[:ticket][:custom_event_id])
      #params[:ticket][:custom_event_id]= params[:custom_event_id]
      logger.info "\n\n CUSTOM EVENT ID #{params[:ticket][:custom_event_id]} \n\n" 
      redirect = "/custom_events/#{@t.custom_event_id}"
      else
        @t.user_id=current_user.id rescue 1 #so i dont have to log in during testing
        @t.ticket_group=@ticket_group
        
        redirect = "/"
        session[:tab]="ticket_tab"
      end
      @t.seat_number=seats[n]
      if @t.save
        @tid=@t.id
        n+=1
        @ticket_group.quantity+=1
        @mygroup.quantity+=1
        logger.info 'ticket created! ' +n.to_s
      else
        logger.info "error for ticket #{n}: #{@t.errors.first.value}"
      end
    end 
    @ticket_group.save
    @mygroup.save
    respond_to do |format|
      format.html { redirect_to redirect}
      format.xml  { render :xml => @tickets }
    end
  end
  
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
  
  def market
    groups=[]
    @ticket_groups=[]
    if params[:event]
      @event=Event.find(params[:event])
      if params[:user_id]
        @tickets = Ticket.find_all_by_event_id(params[:event_id], :conditions=>["user_id=?", params[:user_id]])
      else
        @tickets = Ticket.find_all_by_event_id(params[:event])
        	unsold_tickets=[]
    				for ticket in @tickets
    					unsold_tickets<<ticket unless ticket.sold? || ticket.list==0.0
    				end
      end
    
      for ticket in unsold_tickets
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

    respond_with(@ticket_groups)
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
      event_id=@ticket.event_id
      @ticket_groups=[]
      tickets=Ticket.find_all_by_event_id(event_id)
      tickets.each do |t|
        @ticket_groups<<t.ticket_group
      end
      @ticket_groups.uniq!
  end
  def select_group
    @event_id=params[:event_id]
    @groups=Event.find(@event_id)
  end
  # POST /tickets
  # POST /tickets.xml
=begin
  #NORMAL CREATE
  def create
    
    #create new ticket for each seat - @ticket is ticket 0, so start with 1
    q=params[:quantity].to_i
    n=0
    seats=params[:seats].split(",")
    @ticket_group=TicketGroup.find(params[:ticket][:ticket_group_id])
    if @ticket_group.quantity.nil? #initialize quantity
      @ticket_group.quantity=0
    end
    #params[:ticket][:ticket_group]=@ticket_group
    while n < q 
      t=Ticket.new(params[:ticket])
      #t.ticket_group=@ticket_group
      t.seat_number=seats[n]
      t.user_id=current_user.id rescue 1 #so i dont have to log in during testing
      t.save
      @tid=t.id
      n+=1
      @ticket_group.quantity+=1
      logger.info 'ticket created! ' +n.to_s
    end 
    @ticket_group.save
    if params[:ticket][:sold]==1
      redirect="/sales/new?ticket_id=#{@tid}"
    else
      redirect="/home"
      session[:tab]="ticket_tab"
    end
    respond_with(@ticket_group) do |format|
      format.html {redirect_to redirect}
    end
  end
=end
  

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
  
  # AJAX from home page
  def user_tickets(scope=params[:ticket_scope])
    @tickets=current_user.tickets
      tmp=[]
    if scope=="all"
      for ticket in @tickets
        tmp<<ticket 
      end
      @tickets=tmp
    elsif scope=='upcoming'
      for ticket in @tickets
        tmp<<ticket unless (ticket.event.date<Time.now || ticket.sold?)
      end
      @tickets=tmp
    elsif scope=="expired"
      for ticket in @tickets
        tmp<<ticket unless (ticket.event.date>Time.now || ticket.sold?)
      end
      @tickets=tmp
    end
    #@tickets.sort_by{|t| t.event.date}.uniq!
    groups=[]
    for ticket in @tickets
      groups<<ticket.ticket_group
    end
    @ticket_groups=groups.sort_by{|g| g.tickets.first.event.date}.uniq!
    #@mygroups = []
    #@ticket_groups.each do |tg|
    #  @mygroups << tg.my_ticket_groups.where("user_id = ?", current_user.id)
    #end
    respond_with(@tickets)
  end
end
