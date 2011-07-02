class SalesController < ApplicationController
  respond_to :html, :js, :xml
  def index
    @sales = Sale.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sales }
    end
  end

  # GET /sales/1
  # GET /sales/1.xml
  def show
    @sale = Sale.find(params[:id])
    @group=TicketGroup.find(@sale.ticket_group_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  # GET /sales/new
  # GET /sales/new.xml
  def new
    @sale = Sale.new
    @ticket=Ticket.find(params[:ticket_id])
    @artist=@ticket.artist.name
    @venue=@ticket.venue.name
    @event=@ticket.event
    @group=@ticket.ticket_group
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sale }
    end
  end

  # GET /sales/1/edit
  def edit
    @sale = Sale.find(params[:id])
  end

  # POST /sales
  # POST /sales.xml
  def create
    @sale = Sale.new(params[:sale])
    # TODO decrement seat #s
    quantity=@sale.quantity
    group=TicketGroup.find(params[:ticket_group_id])
    @sale.ticket_group_id=group.id
    tickets=Ticket.find_all_by_ticket_group_id(group.id, :limit=>quantity, :conditions=>["sold=?", 0])
    @sale.tickets=tickets
    @sale.save
    logger.info @sale.tickets
    respond_with(@sale)
  end

  # PUT /sales/1
  # PUT /sales/1.xml
  def update
    @sale = Sale.find(params[:id])

    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to(@sale, :notice => 'Sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.xml
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to(sales_url) }
      format.xml  { head :ok }
    end
  end
end
