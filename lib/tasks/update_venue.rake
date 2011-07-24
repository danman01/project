namespace :update do
  desc "moves existing data to fk relationships"
  task :venues, :needs => :environment do |t, args|
    venues=Venue.all
    venues.each do |venue|
      if venue!=nil

      if venue.region_name
        region=Region.find_by_region_code(venue.region_name) rescue nil
        if region!=nil
          venue.region=region
        end
      end
      if venue.country_name
        country=Country.find_by_name(venue.country_name)
        venue.country=country
      elsif venue.region
        venue.country=venue.region.country
      end
      if n=venue.city_name
        cities=City.find_all_by_name(n)
        if cities.size>1
          cities.each do |c|
            if c.region && c.region.country && venue.country
              if c.region.country.name==venue.country.name 
              if c.region==venue.region
                city=c
                p 'found 1!'
              end
              end
            end
          end
        else
          city=cities[0]
        end
        if n=="Washington" && venue.region=="DC"
          city=City.find(19144)
        end
        venue.city=city
      end
      venue.save
    end
  end
  end
end