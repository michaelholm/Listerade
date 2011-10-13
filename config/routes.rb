Mongo::Application.routes.draw do |map|
  get "home/index"

  get "home/token"

  devise_for :users
  resource :user

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
  
  match '/how-it-works' => 'home#how_it_works'
  match '/how-it-works/buyers' => 'home#how_it_works_buyers'
  match '/how-it-works/sellers' => 'home#how_it_works_sellers'
  
  match '/buyers' => 'home#buyers'
  match '/buyers/consumer' => 'home#buyers_consumer'
  match '/buyers/vip' => 'home#buyers_vip'
  match '/buyers/investor' => 'home#buyers_investor'
  match '/buyers/international' => 'home#buyers_international'
  match '/buyers/fund' => 'home#buyers_fund'
  
  match '/sellers' => 'home#sellers'
  match '/sellers/banks' => 'home#sellers_banks'
  match '/sellers/asset-managers' => 'home#sellers_asset_managers'
  match '/sellers/listing-agents' => 'home#sellers_listing_agents'
  match '/sellers/brokers' => 'home#sellers_brokers'
  match '/sellers/law-firms' => 'home#sellers_law_firms'
  match '/sellers/developers' => 'home#sellers_developers'
  match '/sellers/reit-or-funds' => 'home#sellers_reit_funds'
  match '/sellers/nfp' => 'home#sellers_nfp'
  match '/sellers/title-companies' => 'home#sellers_title_companies'
  
  match '/auctions' => 'home#auctions'
  match '/auctions/real-estate-auctions' => 'home#auctions_real_estate'
  
  match '/sponsors' => 'home#sponsors'
  match '/financing' => 'home#financing'
  match '/contact-us' => 'home#contact_us'
  
  root :to => "home#index"
  
end
