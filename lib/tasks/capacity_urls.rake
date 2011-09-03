#reverse geocode venue locations
#http://api.geonames.org/findNearbyWikipedia?lat=45.5105348&lng=-73.563372&username=stub
# => http://en.wikipedia.org/wiki/M%C3%A9tropolis_%28concert_hall%29
#TODO find by lat lng
#2000 calls per hour
#other data source http://en.wikipedia.org/wiki/List_of_indoor_arenas_in_the_United_States#Seating_capacities_of_municipal_indoor_arenas
require 'open-uri'
namespace :capacity do
  desc "get urls using lat lng from geonames"
  task :urls, :needs => :environment do |t, args|
    base="http://en.wikipedia.org/wiki/"

    v=Venue.find(:all)
    @info=""
    v.each do |venue|
      if (venue.capacity.nil? && venue.capacity_notes.nil? && venue.name!="Unknown venue")
        lat=venue.latitude rescue next 
        lng=venue.longitude rescue next
        #get wikipedia address from geonames
        geo="http://api.geonames.org/findNearbyWikipedia?lat=#{lat}&lng=#{lng}&username=stub"
        p "starting for #{venue.name}"
        #name=CGI::escape(venue.name) rescue next
        #url=base+name
        doc=Nokogiri::HTML(open(geo))
          name=doc.xpath('//entry/title')[0].text rescue nil
          url=doc.xpath('//entry/wikipediaurl')[0].text rescue nil
          p "got url for #{name}: #{url}"
  
          if url!=nil
            @info+="#{venue.id};#{venue.name};#{url},"
          end
          
        end
        
      end
      File.open('wiki_urls.txt', 'w') {|f| f.write(@info) }
    end
end


