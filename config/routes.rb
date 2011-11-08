Money::Application.routes.draw do

  resources :articles do
    resources :comments
  end  

  resources :transactions do
    collection do
      get 'ask_momma'
      get 'widget'
      get 'company'
    end
  end

  resources :deposits

  resources :payments do
    collection do
      get 'bar_graph'
      get 'home'
    end
  end
  
  match 'company' => 'transactions#company'
  match 'ask_momma' => 'transactions#ask_momma'

  resources :payees

  get "activations/create"

  resources :users do
    collection do
      get 'email_alert'
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  resources :user_sessions
  resources :password_resets
  
  match 'login' => 'user_sessions#new'
  match 'logout' => 'user_sessions#destroy'
  
  match 'signup' => 'user#new'
  
  match '/activate/:activation_code' => 'activations#create', :as => :activate

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
  root :to => "transactions#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
