class VenuesController < ApplicationController
  respond_to :js,:xml,:html
  load_and_authorize_resource
  
  # GET /venues
  # GET /venues.xml
  def index
    @venues = Venue.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.xml
  def show
    @venue = Venue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new
    if params[:redirect]
   session[:redirect]=true
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        if session[:redirect]
            redirect="/events/new?venue=#{@venue.id}"
            session[:redirect]=nil
            RAILS_DEFAULT_LOGGER.error('went in to redirect: ' + redirect)
            format.html { redirect_to(redirect, :notice => 'Venue was successfully created.') }
        else
        format.html { redirect_to(@venue, :notice => 'Venue was successfully created.') }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to(@venue, :notice => 'Venue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
  def user_venues(scope=params[:venue_scope])
    if scope=="upcoming"
      tmp=current_user.events
      tmp.reject!{|x|x.date<Time.now}
      tmp2=[]
      tmp.each do |event|
        tmp2<<event.venue unless event.date<Time.now
      end   
      @venues=tmp2 
    else
      @venues=current_user.venues
    end
    @venues.uniq!
    respond_with(@venues)
  end
end
