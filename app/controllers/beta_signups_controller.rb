class BetaSignupsController < ApplicationController
  # GET /beta_signups
  # GET /beta_signups.xml
  load_and_authorize_resource
  autocomplete :region, :name, :extra_data=>[:region_code, :id]
  autocomplete :city, :name, :extra_data=>[:id, :region_id, :country_id]
  
  def index
    @beta_signups = BetaSignup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @beta_signups }
    end
  end

  # GET /beta_signups/1
  # GET /beta_signups/1.xml
  def show
    @beta_signup = BetaSignup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @beta_signup }
    end
  end

  # GET /beta_signups/new
  # GET /beta_signups/new.xml
  def new
    @beta_signup = BetaSignup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @beta_signup }
    end
  end

  # GET /beta_signups/1/edit
  def edit
    @beta_signup = BetaSignup.find(params[:id])
  end

  # POST /beta_signups
  # POST /beta_signups.xml
  def create
    @beta_signup = BetaSignup.new(params[:beta_signup])

    respond_to do |format|
      if @beta_signup.save
        logger.info "NEW BETA SIGNUP #{@beta_signup.to_yaml}"
        flash[:notice] = 'You\'ve successfully signed up for the Beta! We\'ll surely be in touch.'
        flash[:error] = nil
        format.html { render "/home/index?check_out=events" }
        format.xml  { render :xml => @beta_signup, :status => :created, :location => @beta_signup }
      else
        flash[:error] = "There was an error."
        format.html { render "/home/index" }
        format.xml  { render :xml => @beta_signup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /beta_signups/1
  # PUT /beta_signups/1.xml
  def update
    @beta_signup = BetaSignup.find(params[:id])

    respond_to do |format|
      if @beta_signup.update_attributes(params[:beta_signup])
        format.html { redirect_to(@beta_signup, :notice => 'Beta signup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @beta_signup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /beta_signups/1
  # DELETE /beta_signups/1.xml
  def destroy
    @beta_signup = BetaSignup.find(params[:id])
    @beta_signup.destroy

    respond_to do |format|
      format.html { redirect_to(beta_signups_url) }
      format.xml  { head :ok }
    end
  end
end
