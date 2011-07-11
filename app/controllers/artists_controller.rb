class ArtistsController < ApplicationController
  # GET /artists
  # GET /artists.xml
  respond_to :js,:xml,:html
  def index
    @artists = Artist.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.xml
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/new
  # GET /artists/new.xml
  def new
    @artist = Artist.new
    if params[:redirect]
   session[:redirect]=true
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end

  # POST /artists
  # POST /artists.xml
  def create
    @artist = Artist.new(params[:artist])
     
    respond_to do |format|
      if @artist.save
        if session[:redirect]
            redirect="/events/new?artist=#{@artist.id}"
            session[:redirect]=nil
            RAILS_DEFAULT_LOGGER.error('went in to redirect: ' + redirect)
            format.html { redirect_to(redirect, :notice => 'Artist was successfully created.') }
        else
        format.html { redirect_to(@artist, :notice => 'Artist was successfully created.') }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.xml
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        format.html { redirect_to(@artist, :notice => 'Artist was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.xml
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to(artists_url) }
      format.xml  { head :ok }
    end
  end
  
  def user_artists(scope=params[:artist_scope])
    if scope="upcoming"
    tmp=current_user.events
    tmp.reject!{|x|x.date<Time.now}
    tmp2=[]
    tmp.each do |event|
    tmp2<<event.artist unless event.date<Time.now
    end    
    @artists=tmp2
    else
      @artists=current_user.artists
    end
    @artists.uniq!
    respond_with(@artists)
  end
end
