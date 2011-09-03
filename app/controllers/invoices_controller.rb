class InvoicesController < ApplicationController
  load_and_authorize_resource
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def new
    @invoice = Invoice.new
     invoices=current_user.invoices
      @top_customers=[]
      customers=[]
      for each in invoices
        customers<<each.customer_id
      end
      idx = {}
      ids=[]
      customers.each { |i| idx.include?(i) ? idx[i] += 1 : idx[i] = 1} #indexer
      idx.each {|k, v| ids<<k unless v < 2} # get customers with more than 1 invoice for this user
      @top_customers=Customer.find(ids)
    @sales=[]
    if params[:sales].class!=Array
      params[:sales]=[params[:sales]]
    end
    for each in params[:sales] #changing to array for now...
      sale=Sale.find(each)
      @sales<<sale
    end
  end

  def create
    @invoice = Invoice.new(params[:invoice])
    @invoice.user=current_user
    
    @invoice.sales=[Sale.find(params[:sales_ids].to_i)] # TODO need to change for multiple sales
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
  
  def user_invoices(scope=params[:invoice_scope])
    @invoices=current_user.invoices
    @invoices.reject!{|x|x.sales.empty?} 
    if scope=="all"
      tmp=[]
      for invoice in @invoices
        tmp<<invoice
      end
      @invoices=tmp
    elsif scope=='month'
      tmp=[]
      for invoice in @invoices
        tmp<<invoice if invoice.created_at.year==Time.now.year && invoice.created_at.month==Time.now.month
      end
      @invoices=tmp
    elsif scope=='year'
      tmp=[]
      for invoice in @invoices
        tmp<<invoice if invoice.created_at.year==Time.now.year
      end
      @invoices=tmp
    end
    @invoices.uniq!
    respond_with(@invoices)
  end
end
