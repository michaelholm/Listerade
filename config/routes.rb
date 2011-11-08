Mongo::Application.routes.draw do |map|

#   # custom devise routes
#   get "/login", :to => "devise/sessions#new" # Add a custom sign in route for user sign in
#   get "/logout", :to => "devise/sessions#destroy" # Add a custom sing out route for user sign out
#   get "/register", :to => "devise/registrations#new" # Add a Custom Route for Registrations

  devise_for :users
  
  # Resources
  resource :user
  resource :brochure

  resources :pages do
	  collection do
	    put :update_attribute_on_the_spot
	  end
  end
  
  # Primary Navigation routes
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
  
  # Utility routes
  match '/tools' => 'home#tools'
  #match '/brochure-request' => 'brochure#brochure'
  
  # add to faves
#  get  '/users/:user/favorites', :controller => 'users', :action => 'user_favorites_list'
  post '/users/favorites/toggle/:listing_id', :controller => 'users', :action => 'toggle_favorite'
  post '/users/favorites/add/:listing_id', :controller => 'users', :action => 'add_to_favorites'
  post '/users/favorites/remove/:listing_id', :controller => 'users', :action => 'remove_from_favorites'

  # Search/Find
  post '/find', :controller => 'find', :action => 'search'
  get '/find_by_tag/:tag', :controller => 'find', :action => 'find_by_tag'
  get '/find(/:page)', :controller => 'find', :action => 'search'
  get '/listing/:ln', :controller => 'listings', :action => 'find_by_ln'  # listing number
  get '/listing/:ln/ajax', :controller => 'find', :action => 'ajax_find_by_ln'  # 
  get '/listing/new', :controller => 'listings', :action => 'new'
  
  #get '/users/dashboard', :controller => 'users', :action => 'dashboard'
  get '/users/:user', :controller => 'users', :action => 'dashboard' 
  # Default route to home/index
  root :to => "home#index"
  
end
