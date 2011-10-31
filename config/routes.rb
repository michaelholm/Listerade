Mongo::Application.routes.draw do |map|

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
  
  # Search/Find
  post '/find', :controller => 'find', :action => 'search'
  get '/find(/:page)', :controller => 'find', :action => 'search'
  get '/listing/:ln', :controller => 'find', :action => 'find_by_ln'  # listing number
  get '/listing/new', :controller => 'listings', :action => 'new'
  
  
  # Default route to home/index
  root :to => "home#index"
  
end
