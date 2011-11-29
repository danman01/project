class CustomDevise::RegistrationsController < Devise::RegistrationsController
  #resources
  #user views and setting up cancan w/ devise:
  #http://www.tonyamoyal.com/2010/07/28/rails-authentication-with-devise-and-cancan-customizing-devise-controllers/
  
  #setting up recaptcha with devise:
  #https://github.com/plataformatec/devise/wiki/How-To:-Use-Recaptcha-with-Devise
  
  #recaptcha:
  #https://github.com/ambethia/recaptcha/
  
  #devise:
  #https://github.com/plataformatec/devise
  
  #before_filter :check_permissions, :only => [:new, :create, :cancel]
  #skip_before_filter :require_no_authentication
 
  #def check_permissions
  #  authorize! :create, resource
  #end
  
  def create
    #roles=[]
    #params[:role].each {|key, value| roles<<key if value=="1"}
    #logger.info "roles: #{roles}"
     build_resource
     #for r in roles
     #resource.roles<<Role.find_by_name(r)
     #logger.info "roles: #{resource.roles}"
     
      #end
        if resource.save
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_navigational_format?
            sign_in(resource_name, resource)
            respond_with resource, :location => redirect_location(resource_name, resource)
          else
            set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
            expire_session_data_after_sign_in!
            respond_with resource, :location => after_inactive_sign_up_path_for(resource)
          end
        else
          clean_up_passwords(resource)
          respond_with_navigational(resource) { render_with_scope :new }
        end
   end
   
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
       if resource.update_with_password(params[resource_name])
         set_flash_message :notice, :updated if is_navigational_format?
         sign_in resource_name, resource, :bypass => true
         respond_with resource, :location => after_update_path_for(resource)
       else
         clean_up_passwords(resource)
         respond_with_navigational(resource){ render_with_scope :edit }
       end
  end
  
  
   
end