class CustomTicketsController < ApplicationController
  # GET /custom_tickets
  # GET /custom_tickets.xml
  def index
    @custom_tickets = CustomTicket.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @custom_tickets }
    end
  end

  # GET /custom_tickets/1
  # GET /custom_tickets/1.xml
  def show
    @custom_ticket = CustomTicket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @custom_ticket }
    end
  end

  # GET /custom_tickets/new
  # GET /custom_tickets/new.xml
  def new
    @custom_ticket = CustomTicket.new
    #from custom_event
      if params[:custom_event_id]
        @custom_ticket.custom_event=CustomEvent.find(params[:custom_event_id]) 

        if params[:ticket_group]
          @custom_ticket.ticket_group=params[:ticket_group]
        end

          @ticket_groups=TicketGroup.find_all_by_custom_event_id(@custom_ticket.custom_event.id)
          more=Ticket.find_all_by_custom_event_id(@custom_ticket.custom_event.id)
          more.each do |ticket|
            @ticket_groups<<ticket.ticket_group
          end
          @ticket_groups.uniq!
        end

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @custom_ticket }
      end
  end

  # GET /custom_tickets/1/edit
  def edit
    @custom_ticket = CustomTicket.find(params[:id])
  end

  # POST /custom_tickets
  # POST /custom_tickets.xml
  def create
    @custom_ticket = CustomTicket.new(params[:custom_ticket])

    respond_to do |format|
      if @custom_ticket.save
        format.html { redirect_to(@custom_ticket, :notice => 'Custom ticket was successfully created.') }
        format.xml  { render :xml => @custom_ticket, :status => :created, :location => @custom_ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custom_ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /custom_tickets/1
  # PUT /custom_tickets/1.xml
  def update
    @custom_ticket = CustomTicket.find(params[:id])

    respond_to do |format|
      if @custom_ticket.update_attributes(params[:custom_ticket])
        format.html { redirect_to(@custom_ticket, :notice => 'Custom ticket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custom_ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_tickets/1
  # DELETE /custom_tickets/1.xml
  def destroy
    @custom_ticket = CustomTicket.find(params[:id])
    @custom_ticket.destroy

    respond_to do |format|
      format.html { redirect_to(custom_tickets_url) }
      format.xml  { head :ok }
    end
  end
end
