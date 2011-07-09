class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def encode(data)
      ActiveSupport::Base64.encode64(Marshal.dump(data))
   end

  def decode(data)
    Marshal.load(ActiveSupport::Base64.decode64(data))
  end
  
  def round_to( decimals=0 )
    factor = 10.0**decimals
    (self*factor).round / factor
  end
   
end
