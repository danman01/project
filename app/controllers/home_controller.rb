class HomeController < ApplicationController
  def index
    if current_user
    @invoices=current_user.invoices
    @invoices.reject!{|x|x.sales[0].nil?} 
    @events=current_user.events
   
    @artists=[]
    @venues=[]
    @events.uniq!
    @events.each do |e|
      @artists<<e.artist
      @venues<<e.venue
    end
  
    end
  end

end
