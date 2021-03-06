Tickets::Application.routes.draw do
  
  resources :locations

  resources :addresses

  resources :ratings

  match "/messaging"=>"messagings#index"
  post '/index.json'=>'messagings#index'
  match "/custom_tickets/call(/:ticket_group_id)"=>'custom_tickets#call'
  resources :custom_tickets

  resources :looking_fors

  resources :buyers do
    resources :ratings
  end
  match '/sellers/signout'=>'sellers#signout'
  resources :sellers do
    resources :ratings
  end

  resources :custom_events

  resources :beta_signups do
    get :autocomplete_city_name, :on => :collection
    get :autocomplete_region_name, :on => :collection
  end

  match '/tickets/:action' => 'tickets#/[a-z_]+/i'
  
  resources :regions

  resources :countries

  resources :cities

  devise_for :users, :controllers => {:registrations => "custom_devise/registrations" } 
  
  match 'ticket_groups/select/:event_id'=> 'ticket_groups#select'
  
  match '/:name/calendar'=>'search#sk_artist_calendar'
  match '/search'=>'search#search'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"
  match '/home/tos'=>"home#tos"
 
  
  resources :tours

  #match ':controller(/:action)' unless :action.class==Integer
  
  resources :invoices

  resources :customers

  resources :marketplaces

  resources :sales

  resources :tickets do
    collection do
      get :market
    end
  end

  resources :artists do 
    resources :venues
  end

  resources :venues #do
	#resources :events
  #end
  get "home/index"

  resources :events do
    resources :tickets
  end
  
  resources :ticket_groups do
    resources :tickets
  end
  
  resources :users do
    resources :tickets
    resources :artists
    resources :events
    resources :venues
    resources :sales
  end
  
  resources :commissions
  
  # See how all your routes lay out with "rake routes"

   # This is a legacy wild controller route that's not recommended for RESTful applications.
   # Note: This route will make all actions in every controller accessible via GET requests.
   match '/events/select_or_create' => 'events#select_or_create'
   match '/events/:action' => 'events#/[a-z_]+/i'

   match ':controller(/:action(/:id(.:format)))'
   
end
