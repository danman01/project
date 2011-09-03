require 'open-uri'
namespace :capacity do
  desc "serach wikipedia using urls from rake capacity:urls"
  task :save, :needs => :environment do |t, args|

f=File.open('wiki_urls.csv','r')
lines=[]
f.each_line(",") do |row|
lines<<row
end
ids=[]
lines.each do |line|
  @tr=nil
l=line.split(";")
id=l[0]
url=l[2].chomp(",") rescue next
venue=Venue.find(id.to_i)
wiki=Nokogiri::HTML(open(url))
  trs=wiki.css("table.infobox tr")
  if trs.size>1
    trs.each do |t|
      
      if t!=nil && t.children!=nil && t.children.children[0] && t.children.children[0].text=="Capacity" #gets the capacity tr
        @tr=t
      end
    end
    if @tr && @tr.children.children!=nil
    venue.capacity_notes=@tr.children.children.text
    venue.save
    p "capacity for #{venue.name}: #{venue.capacity_notes} \n(url: #{url})"
    end
  else
    p 'no infocard!'
    #TODO search text for capacity
  end
end

end
end