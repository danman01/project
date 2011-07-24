namespace :geo do
  desc "saves all cities from the text file cities15000.txt!"
  task :cities, :needs => :environment do |t, args|
    f=File.open("/Users/dannykirschner/Downloads/cities15000.txt", "r")
    citiesArray=[]
    f.each do |line|
      citiesArray<<line.split("\t")
    end
    for city in citiesArray
      theCity=City.new()
      theCity.geonamesid=city[0]
      theCity.name=city[1]
      theCity.lat=city[4]
      theCity.lng=city[5]
      theCity.country=Country.find_by_country_code(city[8])
      if theCity.region=Region.find_by_region_code(city[10]) 
      else 
        r=Region.new(:region_code=>(city[10]), :country=>Country.find_by_country_code(city[8]))
        theCity.region=r
        r.save
      end
        theCity.pop=city[14]
        theCity.save
        print theCity.name + " saved!\n"
    end
  end
end