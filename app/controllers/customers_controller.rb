class CustomersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
    @sales=params[:sales]
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      if params[:sales]
        redirect_to new_invoice_path(:sales=>params[:sales], :user=>current_user.id)
      else
      redirect_to @customer, :notice => "Successfully created customer."
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to @customer, :notice  => "Successfully updated customer."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to customers_url, :notice => "Successfully destroyed customer."
  end
end
