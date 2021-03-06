Mironov::Application.routes.draw do

  root :to => 'main#index'

  get 'application/plan_create', :as => :plan_create
  get 'application/implementation_create', :as => :implementation_create

  devise_for :admin_users, ActiveAdmin::Devise.config do
    ActiveAdmin.routes(self)
  end

  devise_for :users do
    get 'plan/next_day', :as => :plan_next_day
    get 'plan/prev_day', :as => :plan_prev_day

    get 'implementation/next_day', :as => :implementation_next_day
    get 'implementation/prev_day', :as => :implementation_prev_day

    get 'cash/next_day', :as => :cash_next_day
    get 'cash/prev_day', :as => :cash_prev_day

    get 'cashc/next_day', :as => :cashc_next_day
    get 'cashc/prev_day', :as => :cashc_prev_day

    get "sold_done/index" , :as => :sold_done

    match 'balance/' => 'balance#index'
    match 'cash/' => 'cash#index'
    match 'cashc/' => 'cashc#index'
    match 'implementation/' => 'implementation#index'
    match 'implementation/:id' => 'implementation#show', :as => :implementationshow
    match 'implementation/:id/all' => 'implementation#all', :as => :implementationall
    match 'plan/' => 'plan#index'
    match 'plan/:id' => 'plan#show', :as => :planshow
    match 'plan/:id/all' => 'plan#all', :as => :planall
    match 'conference/:id' => 'conference#show', :as => :conferenceshow
    match 'conference/' => 'conference#index'

  end
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
