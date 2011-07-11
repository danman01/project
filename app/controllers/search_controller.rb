class SearchController < ApplicationController
  respond_to :js,:xml,:html

  def search

  end
  def results
    artist=params[:name]
     if !Artist.find(:all, :conditions=>['name LIKE ? and mbid IS NOT NULL', artist]).empty?
         @artists=Artist.find(:all, :conditions=>['name LIKE ? and mbid IS NOT NULL', artist])
      else
      api_key="O4d25zZpTn7zfxZP"
      host="api.songkick.com"
      path="/api/3.0/search/artists.xml"
      params="?query="+CGI::escape(artist)+"&apikey="+api_key
      http=Net::HTTP.new(host)
      headers=
      {
        'Content-Type' => 'application/atom+xml',
        'Host'=> host,
        'User-Agent'=>"ruby/net::http"
      }
      resp, data=http.get(path+params, headers)
      if resp.code=="200"
        @artists=[]
        doc = Nokogiri::XML(data) 
        doc.xpath('resultsPage/results/artist').each do |artist|
          @artists<<artist
          logger.info artist['displayName']
        end
        #title=doc.xpath('//xmlns:title').first.children.text
        #node=doc.xpath('//xmlns:entry')
      end
      end
      respond_with(@artists)
  
  end
  
  def sk_artist_search(artist=params[:name])
    if !Artist.find(:all, :conditions=>['name LIKE ? and mbid IS NOT NULL', artist]).empty?
       @artists=Artist.find(:all, :conditions=>['name LIKE ? and mbid IS NOT NULL', artist])
    else
    api_key="O4d25zZpTn7zfxZP"
    host="api.songkick.com"
    path="/api/3.0/search/artists.xml"
    params="?query="+CGI::escape(artist)+"&apikey="+api_key
    http=Net::HTTP.new(host)
    headers=
    {
      'Content-Type' => 'application/atom+xml',
      'Host'=> host,
      'User-Agent'=>"ruby/net::http"
    }
    resp, data=http.get(path+params, headers)
    if resp.code=="200"
      @artists=[]
      doc = Nokogiri::XML(data) 
      doc.xpath('resultsPage/results/artist').each do |artist|
        @artists<<artist
        #logger.info artist['displayName']
      end
      #title=doc.xpath('//xmlns:title').first.children.text
      #node=doc.xpath('//xmlns:entry')
    end
    end
    respond_with(@artists)

  end
  def sk_events(artist_name=params[:name], mbid=params[:mbid], eventsHref=params[:eventsHref])
    api_key="O4d25zZpTn7zfxZP"
    if @artist=Artist.find_by_mbid(mbid)
      #@artist.eventsHref=eventsHref unless @artist.eventHref!=nil
    else 
      @artist=Artist.new(:mbid=>mbid, :eventsHref=>eventsHref, :name=>artist_name, :url=>params[:url], :on_tour_until=>params[:on_tour_until])
      @artist.save
      logger.info @artist.name +"created!"
    end
    host="api.songkick.com"
    path="/api/3.0/events.xml"
    params="?apikey="+api_key+"&artist_name="+artist_name
    #+"&min_date=2010-01-01&max_date=2011-01-01"
    http=Net::HTTP.new(host)
    headers=
    {
      'Content-Type' => 'application/atom+xml',
      'Host'=> host,
      'User-Agent'=>"ruby/net::http"
    }
    resp, data=http.get(path+params, headers)
    if resp.code=="200"
      doc = Nokogiri::XML(data) 
      @num=doc.children[0].attributes['totalEntries'].value
      @events=[]
      doc.xpath('resultsPage/results/event').each do |event|
        @events<<event
        venue=event.xpath('venue') #gets nodeset
        venue=venue[0] #gets element
        @venue=check_for_venue(venue)
      end

    end
    respond_with(@events)
  end

  def sk_artist_calendar(artist=params[:id], eventsHref=params[:eventsHref], mbid=params[:mbid], name=params[:name])
    api_key="O4d25zZpTn7zfxZP"
    if @artist=Artist.find_by_mbid(mbid)
      #@artist.eventsHref=eventsHref unless @artist.eventHref!=nil
    elsif @artist=Artist.find(:first, :conditions=>['name LIKE ?', name])
      @artist.update_attributes(:mbid=>mbid, :eventsHref=>eventsHref, :name=>params[:name], :url=>params[:url], :on_tour_until=>params[:on_tour_until])
    else
      @artist=Artist.new(:mbid=>mbid, :eventsHref=>eventsHref, :name=>params[:name], :url=>params[:url], :on_tour_until=>params[:on_tour_until])
      @artist.save
      logger.info params[:name] + "created!"
    end
    host="api.songkick.com"
    path="/api/3.0/artists/mbid:#{mbid}/calendar.xml"
    params="?apikey="+api_key
    http=Net::HTTP.new(host)
    headers=
    {
      'Content-Type' => 'application/atom+xml',
      'Host'=> host,
      'User-Agent'=>"ruby/net::http"
    }
    resp, data=http.get(path+params, headers)
    if resp.code=="200"
      @events=[]
      doc = Nokogiri::XML(data) 
      @num=doc.children[0].attributes['totalEntries'].value
        doc.xpath('resultsPage/results/event').each do |event|
          @events<<event
          venue=event.xpath('venue') #gets nodeset
          venue=venue[0] #gets element
          check_for_venue(venue)
        end
  

    end
  
    respond_with(@events)
  end
  
  def check_for_venue(venue)
    name=venue["displayName"] rescue nil
    capacity=venue["capacity"] rescue nil
    longitude=venue['lng'] rescue nil
    latitude=venue['lat'] rescue nil
    url=venue["uri"] rescue nil
    loc=venue.xpath('metroArea')[0] rescue nil
    city=loc['displayName']
    state=loc.xpath('state')[0]['displayName'] rescue nil
    country=loc.xpath('country')[0]['displayName'] rescue nil
    
    if @venue=Venue.find_by_name(name)
    else
      @venue=Venue.new(:name=>name, :capacity=>capacity, :longitude=>longitude, :latitude=>latitude, :url=>url, :city=>city, :state=>state, :country=>country)
      @venue.save
    end
  end
end