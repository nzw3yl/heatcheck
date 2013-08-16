Heatcheck::Application.routes.draw do

  require 'sidekiq/web'

  resources :invites
  resources :contracts
  resources :issue_histories
  resources :heat_logs
  resources :memberships, :only => :index
#  resources :contacts
  get "heat_maps/update"
  get "heat_maps/history"
  get "lobbies/show"
  put "lobbies/update"
  
  get 'switch/:new_provider', :controller => :providers, :action => :switch
  
  resources :measures

  resources :providers, :shallow => true do
    resources :contacts 
    member do
      get 'issues'
      get 'plans'
    end
  end
  
  resources :partners, :shallow => true do
    resources :issues do
        resources :plans
    end
    member do
      get 'show_heat'
      get 'show_contacts'
      get 'show_history'
      get 'show_customers'
    end
    get 'show_map', on: :collection
  end
  
  resources :partners do
    resources :contacts
    resources :issues, :only => [:show, :edit, :update]
  end
  
  resources :customers, :shallow => true do
    resources :issues do
        resources :plans
    end
    get 'show_heat', :on => :member
    get 'show_contacts', :on => :member
    get 'show_history', :on => :member
  end
  
  resources :customers do
    resources :contacts
    resources :issues, :only => [:show, :edit, :update]
  end
  
  match "/customers/:customer_id/issues/:issue_id/plans" => "plans#index", :via => :get, :as => :customer_issue_plans
  match "/partners/:partner_id/issues/:issue_id/plans" => "plans#index", :via => :get, :as => :partner_issue_plans
  
  authenticated :user do
    root :to => "home#index"
    mount Sidekiq::Web, at: '/heat_monitor'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
