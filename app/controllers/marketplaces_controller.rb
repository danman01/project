class MarketplacesController < ApplicationController
  # GET /marketplaces
  # GET /marketplaces.xml
  def index
    @marketplaces = Marketplace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @marketplaces }
    end
  end

  # GET /marketplaces/1
  # GET /marketplaces/1.xml
  def show
    @marketplace = Marketplace.find_by_name(params[:id]) || Marketplace.find(params[:id])
    if current_user
      invoices=current_user.invoices
      @invoices=[]
      for invoice in invoices
        @invoices<<invoice unless invoice.sales.first.marketplace_id!=@marketplace.id
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @marketplace }
    end
  end

  # GET /marketplaces/new
  # GET /marketplaces/new.xml
  def new
    @marketplace = Marketplace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @marketplace }
    end
  end

  # GET /marketplaces/1/edit
  def edit
    @marketplace = Marketplace.find(params[:id])
  end

  # POST /marketplaces
  # POST /marketplaces.xml
  def create
    @marketplace = Marketplace.new(params[:marketplace])

    respond_to do |format|
      if @marketplace.save
        format.html { redirect_to(@marketplace, :notice => 'Marketplace was successfully created.') }
        format.xml  { render :xml => @marketplace, :status => :created, :location => @marketplace }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @marketplace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /marketplaces/1
  # PUT /marketplaces/1.xml
  def update
    @marketplace = Marketplace.find(params[:id])

    respond_to do |format|
      if @marketplace.update_attributes(params[:marketplace])
        format.html { redirect_to(@marketplace, :notice => 'Marketplace was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @marketplace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /marketplaces/1
  # DELETE /marketplaces/1.xml
  def destroy
    @marketplace = Marketplace.find(params[:id])
    @marketplace.destroy

    respond_to do |format|
      format.html { redirect_to(marketplaces_url) }
      format.xml  { head :ok }
    end
  end
end
