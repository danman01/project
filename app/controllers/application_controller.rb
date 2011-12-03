class ApplicationController < ActionController::Base
  protect_from_forgery
  #before_filter :authenticate_user!, :only =>[:create, :update]
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to '/', :alert => exception.message
  end
  
  layout :choose_layout
  before_filter :set_globals
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
  
  def hit_tropo_end_point(params = {})
    params.merge!('token' => AppSettings::TROPO_VOICE_TOKEN)
    query_string = params.map {|k,v| [k,v].join('=')}.join('&')
    param_list = "?#{query_string}" if query_string.present?

    logger.error "*"*80
    logger.error "curling #{AppSettings::TROPO_API}#{param_list}"
    logger.error "*"*80

    `curl "#{AppSettings::TROPO_API}#{param_list}"`
  end
  
  protected
  def set_globals
    @custom_events=CustomEvent.find(:all)
  end
  
  
end
