class BuyersController < ApplicationController
  # GET /buyers
  # GET /buyers.xml
  def index
    @buyers = Buyer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @buyers }
    end
  end

  # GET /buyers/1
  # GET /buyers/1.xml
  def show
    @buyer = Buyer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @buyer }
    end
  end

  # GET /buyers/new
  # GET /buyers/new.xml
  def new
    @buyer = Buyer.new
    if session[:seller]
      seller=Seller.find(session[:seller])
      @buyer.email = seller.email
      @buyer.phone = seller.phone
      @buyer.first_name = seller.first_name
      @buyer.last_name = seller.last_name
      @buyer.location = seller.location
    end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @buyer }
    end
  end

  # GET /buyers/1/edit
  def edit
    @buyer = Buyer.find(params[:id])
  end

  # POST /buyers
  # POST /buyers.xml
  def create
    @buyer = Buyer.new(params[:buyer])
    
    respond_to do |format|
      if @buyer.save
        session[:buyer] = @buyer.id
        logger.info "Set buyer session"
        format.html { redirect_to(@buyer, :notice => 'Buyer was successfully created.') }
        format.xml  { render :xml => @buyer, :status => :created, :location => @buyer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @buyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /buyers/1
  # PUT /buyers/1.xml
  def update
    @buyer = Buyer.find(params[:id])

    respond_to do |format|
      if @buyer.update_attributes(params[:buyer])
        format.html { redirect_to(@buyer, :notice => 'Buyer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @buyer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /buyers/1
  # DELETE /buyers/1.xml
  def destroy
    @buyer = Buyer.find(params[:id])
    @buyer.destroy

    respond_to do |format|
      format.html { redirect_to(buyers_url) }
      format.xml  { head :ok }
    end
  end
end
