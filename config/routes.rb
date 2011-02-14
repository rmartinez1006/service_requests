ServiceRequests::Application.routes.draw do
  resources :posts

  #get "support_request/index"

  #get "support_request/show"

  #get "support_request/new"

  #get "support_request/cancel"

  #get "support_request/comment"

  
  namespace :requests do resources :support_requests end
  namespace :request do
     resources :support_requests
  end

  namespace :budgets do resources :budget_supplies end

  namespace :budgets do resources :budgets end

  

  #RMO
  #namespace :requests do
  #   match 'support_request/index' => 'support_request/index', :as => :index
  #end

  namespace :budgets do 
     match 'budgets/:id/budget_fm1' => 'budgets#budget_fm1', :as => :budget_fm1
     match 'budgets/:id/budget_fm2' => 'budgets#budget_fm2', :as => :budget_fm2
     match 'budgets/:id/delete_supply' => 'budgets#delete_supply', :as => :delete_supply
     match 'budgets/:id/delete_supply2' => 'budgets#delete_supply2', :as => :delete_supply2
     match 'budgets/:id/budget_fm1_edit' => 'budgets#budget_fm1_edit', :as => :budget_fm1_edit     
  end

  namespace :catalogs do resources :supplies end

  namespace :administration do
    match 'login', :to => 'user_sessions#new', :as => 'login'
    match 'logout', :to => 'user_sessions#destroy', :as => 'logout'
  end

  namespace :administration do resources :user_sessions end

  namespace :requests_administration do resources :delegations end

  namespace :requests_administration do resources :commentaries end

  namespace :requests_administration do resources :support_requests end

  #RMO
  namespace :requests_administration do
    match 'support_requests/:id/scale' => 'support_requests#scale', :as => :scale
  end

#  resources :requests do
#    resources :budgets do
#      resources :main_budget
#    end
#  end


  namespace :administration do resources :user_hierachies end

  namespace :administration do resources :users end

  namespace :administration do resources :user_roles end

  namespace :catalogs do resources :ubications end

  namespace :catalogs do resources :units end

  namespace :catalogs do resources :comment_types end

  namespace :catalogs do resources :priorities end

  namespace :catalogs do resources :request_statuses end

  namespace :catalogs do resources :support_types end

  namespace :catalogs do resources :suppliers end

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
