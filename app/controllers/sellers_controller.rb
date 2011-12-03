class SellersController < ApplicationController
  # GET /sellers
  # GET /sellers.xml
  def index
    @sellers = Seller.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sellers }
    end
  end

  # GET /sellers/1
  # GET /sellers/1.xml
  def show
    @seller = Seller.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seller }
    end
  end

  # GET /sellers/new
  # GET /sellers/new.xml
  def new
    @seller = Seller.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seller }
    end
  end

  # GET /sellers/1/edit
  def edit
    @seller = Seller.find(params[:id])
  end

  # POST /sellers
  # POST /sellers.xml
  def create
    @seller = Seller.new(params[:seller])
    respond_to do |format|
      if @seller.save
        flash[:notice]="Success!"
        session[:seller]=@seller.id
        redirect="/home/index"
      else
        flash[:error]="No record found. Sign up for a new one"
        redirect="/sellers/new"
      end
        format.html {redirect_to redirect}
    end
  end
  
  def signin
    seller=Seller.find_by_email(params[:email])
    if seller
      session[:seller]=seller.id
      flash[:notice]="Success!"
      redirect="/custom_events/#{params[:custom_event_id]}"
    else
      flash[:error]="No record found. Sign up for a new one"
      redirect="/sellers/new?custom_event_id=#{params[:custom_event_id]}"
    end
    respond_to do |format|
      format.html {redirect_to redirect}
    end
  end
  
  def signout
    session[:seller]=nil
    session[:buyer]=nil
    flash[:alert]="Signed out!"
    respond_to do |format|
      format.html {redirect_to "/home/index"}
    end
  end

  # PUT /sellers/1
  # PUT /sellers/1.xml
  def update
    @seller = Seller.find(params[:id])

    respond_to do |format|
      if @seller.update_attributes(params[:seller])
        format.html { redirect_to(@seller, :notice => 'Seller was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seller.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sellers/1
  # DELETE /sellers/1.xml
  def destroy
    @seller = Seller.find(params[:id])
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to(sellers_url) }
      format.xml  { head :ok }
    end
  end
end
