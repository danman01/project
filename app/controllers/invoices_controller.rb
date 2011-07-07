class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
    @sales=[]
    for each in params[:sales]
      sale=Sale.find(each)
      @sales<<sale
    end
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.user=current_user
    
    @invoice.sales=[Sale.find(params[:sales_ids].to_i)] # need to change for multiple sales
    if @invoice.save
      sales=@invoice.sales
      sales.each do |sale|
        tickets=sale.tickets
        tickets.each do |ticket|
          if ticket.sold==0
          ticket.sold=1
          ticket.save
          else
          logger.info "ticket already sold! id:#{ticket.id}"
          end
        end
         group=sale.tickets.first.ticket_group
         group.quantity-=sale.quantity
         group.save
      end
     
      redirect_to @invoice, :notice => "Sale finalized!"
    else
      render :action => 'new'
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to @invoice, :notice  => "Successfully updated invoice."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    #credit ticket group quantity and turn sold bit to 0 for tickets
     sales=@invoice.sales
      sales.each do |sale|
        tickets=sale.tickets
        tickets.each do |ticket|
          if ticket.sold==1
          ticket.sold=0
          ticket.save
          else
          logger.info "ticket hasnt been sold! id:#{ticket.id}"
          end
        end
         group=sale.tickets.first.ticket_group
         group.quantity+=sale.quantity
         group.save
      end
    @invoice.destroy
    redirect_to invoices_url, :notice => "Successfully destroyed invoice."
  end
end
