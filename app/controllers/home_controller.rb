class HomeController < ApplicationController
  def index
    if current_user
    @invoices=current_user.invoices
    #@invoices.reject!{|x|x.sales[0].nil?} 
    @invoices.each do |x|
      if x.sales.empty?
        b=1
      end
      if b==1
        @invoices.delete(x)
      end
    end    
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
