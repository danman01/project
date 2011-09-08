class SalesController < ApplicationController
  respond_to :html, :js, :xml
  load_and_authorize_resource
  layout "sale_flow"
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
    @group=TicketGroup.find(@sale.ticket_group_id)
    
    quantity=@group.quantity
    @event=@sale.tickets.first.event
    @venue=@sale.tickets.first.venue.name
    @artist=@sale.tickets.first.artist.name
    respond_with(@sale)
  end

  # POST /sales
  # POST /sales.xml
  def create
    @user=User.find(current_user) #should find current user
    @sale = Sale.new(params[:sale])
    # TODO decrement seat #s
    quantity=@sale.quantity
    group=TicketGroup.find(params[:ticket_group_id])
    @sale.ticket_group_id=group.id
    tickets=Ticket.find_all_by_ticket_group_id(group.id, :limit=>quantity, :conditions=>["sold=?", 0])
    @sale.tickets=tickets
    @sale.save
    respond_with(@sale) do |format|
      format.html{redirect_to new_invoice_path(:sales=>[@sale], :user=>@user)}
    end
  end

  # PUT /sales/1
  # PUT /sales/1.xml
  def update
    @user=User.find(current_user) #should find current user
    @sale = Sale.find(params[:id])
    @sale.update_attributes(params[:sale])
    quantity=@sale.quantity
    group=TicketGroup.find(params[:ticket_group_id])
    @sale.ticket_group_id=group.id
    tickets=Ticket.find_all_by_ticket_group_id(group.id, :limit=>quantity, :conditions=>["sold=?", 0])
    @sale.tickets=tickets
    @sale.save
    respond_with(@sale) do |format|
      format.html{redirect_to new_invoice_path(:sales=>[@sale], :user=>@user)}
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
