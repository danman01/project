class HomeController < ApplicationController
  def index
    if current_user
      @invoices=current_user.invoices
      #@invoices.reject!{|x|x.sales[0].nil?} 
      #TODO convert invoice_id to integer in Sale
      @invoices.each do |x|
        b=0
        if Sale.find_all_by_invoice_id(x.id.to_s).nil?
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

  def invite_friends

  end
  
  
end
