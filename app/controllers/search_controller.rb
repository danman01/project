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
    if @artist=Artist.find_by_mbid(mbid)
      #@artist.eventsHref=eventsHref unless @artist.eventHref!=nil
    else 
      @artist=Artist.new(:mbid=>mbid, :eventsHref=>eventsHref, :name=>artist_name, :url=>params[:url], :on_tour_until=>params[:on_tour_until])
      @artist.save
      logger.info @artist.name +"created!"
    end
    api_key="O4d25zZpTn7zfxZP"
    
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
  def location_calendar(city=params[:city])
    cities=City.find_all_by_name(city)
    @events=[]
    @venues=[]
    for each in cities
    @venues=@venues | Venue.find(:all, :conditions=>['city_id LIKE ?', each.id])
    end
    if !@venues.nil?
      @venues.each do |venue|
        venue.events.each do |event|
          if event.upcoming
            @events<<event
          end
        end
      end
    end
    if @events.nil?
      #find nearby cities
    end
    @cities=cities
    respond_with(@events)
  end
  def sk_artist_calendar(artist=params[:id], eventsHref=params[:eventsHref], mbid=params[:mbid], name=params[:artist_name])
    if mbid #deals with bands not in music brainz
      if @artist=Artist.find_by_mbid(mbid)
        #@artist.eventsHref=eventsHref unless @artist.eventHref!=nil
      end
    end
    if @artist.nil? #if dont have mbid saved in our db, try searching by name
      if @artist=Artist.find(:first, :conditions=>['name LIKE ?', name])
        @artist.update_attributes(:mbid=>mbid, :eventsHref=>eventsHref, :name=>name, :url=>params[:url], :on_tour_until=>params[:on_tour_until])
        logger.info @artist.to_yaml
      else #if no name or mbid, create them in our db.  will be loaded in next attempt 
        @artist=Artist.new(:mbid=>mbid, :eventsHref=>eventsHref, :name=>name, :url=>params[:url], :on_tour_until=>params[:on_tour_until])
        @artist.save
      end

    end
    api_key="O4d25zZpTn7zfxZP"
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
    #uncomment if else, and change update attributes to save to stop updateing each time on search
    name=venue["displayName"] rescue nil
    #if 
      @venue=Venue.find_by_name(name)
    #else
    capacity=venue["capacity"] rescue nil
    longitude=venue['lng'] rescue nil
    latitude=venue['lat'] rescue nil
    url=venue["uri"] rescue nil
    loc=venue.xpath('metroArea')[0] rescue nil
    if cn=loc.xpath('country')[0]['displayName']
    country=Country.find_by_country_code(cn) #US uses US, others use name
    if !country
      country=Country.find_by_name(cn)
    end
    end
    if loc.xpath('state')[0]
      rg=loc.xpath('state')[0]['displayName'] 
      region=Region.find_by_region_code(rg)
      if !region
        region=Region.new(:region_code=>rg,:country=>country)
        region.save
      end
        
    end
    if ct=loc['displayName']
      if region && city=City.find_by_name(ct, :conditions=>["region_id=?", region.id])
      elsif city=City.find_by_name(ct)
      elsif region
        city=City.new(:name=>ct, :region=>region,:status=>0)
        city.save
      end
    end
    #http://www.geonames.org/export/web-services.html
      
    if @venue
      @venue.update_attributes(:name=>name, :capacity=>capacity, :longitude=>longitude, :latitude=>latitude, :url=>url, :city=>city, :region=>region, :country=>country)
    else
      @venue=Venue.new(:name=>name, :capacity=>capacity, :longitude=>longitude, :latitude=>latitude, :url=>url, :city=>city, :region=>region, :country=>country)
      @venue.save
    end
  end
end