class CustomEventsController < ApplicationController
  # GET /custom_events
  # GET /custom_events.xml
  def index
    @custom_events = CustomEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @custom_events }
    end
  end

  # GET /custom_events/1
  # GET /custom_events/1.xml
  def show
    @custom_event = CustomEvent.find(params[:id])
    @tickets=@custom_event.custom_tickets
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @custom_event }
    end
  end

  # GET /custom_events/new
  # GET /custom_events/new.xml
  def new
    @custom_event = CustomEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @custom_event }
    end
  end

  # GET /custom_events/1/edit
  def edit
    @custom_event = CustomEvent.find(params[:id])
  end

  # POST /custom_events
  # POST /custom_events.xml
  def create
    @custom_event = CustomEvent.new(params[:custom_event])

    respond_to do |format|
      if @custom_event.save
        format.html { redirect_to(@custom_event, :notice => 'Custom event was successfully created.') }
        format.xml  { render :xml => @custom_event, :status => :created, :location => @custom_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @custom_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /custom_events/1
  # PUT /custom_events/1.xml
  def update
    @custom_event = CustomEvent.find(params[:id])

    respond_to do |format|
      if @custom_event.update_attributes(params[:custom_event])
        format.html { redirect_to(@custom_event, :notice => 'Custom event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @custom_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_events/1
  # DELETE /custom_events/1.xml
  def destroy
    @custom_event = CustomEvent.find(params[:id])
    @custom_event.destroy

    respond_to do |format|
      format.html { redirect_to(custom_events_url) }
      format.xml  { head :ok }
    end
  end
end
