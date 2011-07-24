namespace :geo do
  desc "saves all countries!"
  task :countries, :needs => :environment do |t, args|
    require 'open-uri'
    host="http://api.geonames.org"
    path="/countryInfo"
    params="?username=stub"
    doc=Nokogiri::XML(open(host+path+params))
    countries=doc.css('geonames country')
    countries.each do |country|
      ccode=country.css('countryCode').text
      cn=country.css('countryName').text
      bBoxWest=country.css('bBoxWest').text
      bBoxEast=country.css('bBoxEast').text
      bBoxSouth=country.css('bBoxSouth').text
      bBoxNorth=country.css('bBoxNorth').text
      country=Country.new(:name=>cn, :country_code=>ccode,:b_box_north=>bBoxNorth,:b_box_south=>bBoxSouth,:b_box_east=>bBoxEast,:b_box_west=>bBoxWest)
      country.save
      print country.name + " saved!\n"
    end
  end
end