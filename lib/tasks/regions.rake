desc "serach wikipedia using urls from rake capacity:urls"
task :regions, :needs => :environment do |t, args|
  country=Country.find(482)
  
  f=File.open('states.csv','r')
  lines=[]
  n=0
  f.each_line("\n") do |row|
    if n==0
      n+=1
      next
    end
    l=row.split(",")
    name=l[0].gsub('"',"")
    ab=l[1].gsub('"',"").gsub('\n"',"")

    if region=Region.find_by_region_code(ab) 
      region.name=name
      region.save
      p "name added! #{name}, #{ab}"
    else
      create_region(name,ab,country)

    end
    n+=1
  end

end

def create_region(name,ab,country)
  r=Region.new(:region_code=>ab, :name=>name, :country=>country)
  p "created region! #{name} #{ab}"
  r.save
end