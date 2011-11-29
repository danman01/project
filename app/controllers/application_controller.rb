class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :only =>[:create, :update]
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to :back, :alert => exception.message
  end
  
  layout :choose_layout

    def choose_layout
      if user_signed_in? && current_user.role?("admin")
        # action_name == 'index'
        return 'application'
      else
        return 'beta'
      end
    end
    
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
  
  def store_location
    if request.get? && request.format.html? && !request.xhr? &&
  !devise_controller?
      session[:"scope_return_to"] = request.request_uri
    end
  end
  
  
end
