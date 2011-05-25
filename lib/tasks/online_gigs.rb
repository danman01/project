#scrape online gigs page, add venues to db

#!/Users/dannykirschner/.rvm/rubies/ruby-1.8.7-p334/bin/ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'fastercsv'


puts "fetching venue names..."

 hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/4.0.0", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
 my_html = ""
 root="http://onlinegigs.com/entities.asp?entity=venues&State="
 states = ['AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','N','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']
 states.each do |state|
   url=root+state
 open(url, hdrs).each {|s| my_html << s}
 @doc= Hpricot(my_html)
 links=[]
 
 puts "writing to file..."
 
   if @web_doc!=nil
 
     @web_doc.search("a[@class*=artist]").each {|name| array<<name.innerHTML}
     count=0
     array.each do |a|
   artist_name = a.to_s.strip!
   #sphinx_array = {:limit => 1, :mode => :any, :sort_mode => [:relevance, 'name']}
   #tmp=Artist.find_with_sphinx(artist_name, :sphinx => sphinx_array) 
   #if(!tmp.nil?)
   #@hypem_artists << tmp[0]
	@hypem_artists << artist_name
   end
   @hypem_artists.uniq!
   if !File.exist? "hypem.csv"
   File.open("hypem.csv", 'w') {|f| f.write("")}
   end
   File.open("hypem.csv", 'a+') {|f| 
      f.write (Time.now.to_s + "\n" + "===================" + "\n")
   @hypem_artists.each do |artist|
      f.write (artist + ", ")
    end
  }
  f.write("\n")
  puts "success!"
 else
   puts 'error parsing page!'
 end