class EventsController < ApplicationController
  respond_to :js,:xml,:html
  load_and_authorize_resource
  def index
    @events = Event.all


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])
    	@quantity=0
    	groups=[]
			@event.tickets.each do |t|
			groups<<t.ticket_group
			
		  end
		  groups.uniq!
		  groups.each do |g|
		    @quantity+=g.quantity
		  end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def select_or_create(name=params[:name], date=params[:date], time=params[:time], venue=params[:venue], artist_id=params[:artist_id])
     venue=Venue.find_by_name(venue) rescue nil
      logger.info "\n\n venue: #{venue} \n \n"
      if @event=Event.find_by_name(name)
      else
        @event=Event.new(:name=>name,:artist_id=>artist_id, :venue=>venue)
        if date.nil?
          date=""
        end
        if time.nil?
          time=""
        end
        @event.time=(date+" " + time).to_datetime unless time==""
        @event.date=date.to_datetime unless date==""
        @event.save
        logger.info 'new event!' + "\n #{@event.name}"
      end
      respond_with(@event)
  end
  
  def new
    @event = Event.new
    if params[:artist]
      @event.artist_id=params[:artist]
    end
    if params[:venue]
      @event.venue_id=params[:venue]
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
   if @event.name==''
     @event.name=@event.artist.name + ' at ' + @event.venue.name + " (#{@event.date.strftime("%a, %b %e %Y")})"
  end

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
  
  # AJAX from home page
  def user_events(scope=params[:event_scope])
    @events=current_user.events
    if params[:event_scope]=="upcoming"
      @events.reject!{|x|x.date<Time.now}
    end
    @events.uniq!
    respond_with(@events)
  end
end
