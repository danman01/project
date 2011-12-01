class BetaSignupsController < ApplicationController
  # GET /beta_signups
  # GET /beta_signups.xml
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
        format.html { redirect_to(@beta_signup, :notice => 'Beta signup was successfully created.') }
        format.xml  { render :xml => @beta_signup, :status => :created, :location => @beta_signup }
      else
        format.html { render :action => "new" }
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
