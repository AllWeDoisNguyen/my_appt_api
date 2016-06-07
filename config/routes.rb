Rails.application.routes.draw do
  root 'appointments#index'

  resources :appointments

  # match '/:id', :to => "appointments#show", :as => :full_name, :via => :get
  # post '/appointments/(.:format)' => 'appointments#set_appointment'
end



# Failure/Error: patch "/appointments?full_name=jo blume", {:appointment => {:last_name => "Bobby"} }
     
     # ActionController::RoutingError:
       # No route matches [PATCH] "/appointments"
