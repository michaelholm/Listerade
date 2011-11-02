class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :token
  
  def index
  	@listings = Listing.where(:featured => true).paginate({
		  :sort => :LP.desc,
		  :per_page => 15, 
		  :page     => params[:page],
		})
  
  end

  # MAIN NAV #
  # How it Works
  def how_it_works
  	render :template => '/home/how_it_works/how_it_works'
  end

  def how_it_works_buyers
  	render :template => '/home/how_it_works/buyers'
  end

  def how_it_works_sellers
  	render :template => '/home/how_it_works/sellers'
  end

  # Buyers
  def buyers
  	render :template => '/home/buyers/buyers'
  end
  
  def buyers_consumer
  	render :template => '/home/buyers/consumer'
  end
  
  def buyers_vip
  	render :template => '/home/buyers/vip'
  end
  
  def buyers_investor
  	render :template => '/home/buyers/investor'
  end
  
  def buyers_fund
  	render :template => '/home/buyers/fund'
  end
  
  def buyers_international
  	render :template => '/home/buyers/international'
  end

  # Sellers
  def sellers
  	render :template => '/home/sellers/sellers'
  end
  
  def sellers_asset_managers
  	render :template => '/home/sellers/asset_managers'
  end

  def sellers_banks
  	render :template => '/home/sellers/banks'
  end

  def sellers_brokers
  	render :template => '/home/sellers/brokers'
  end

  def sellers_listing_agents
  	render :template => '/home/sellers/listing_agents'
  end

  def sellers_developers
  	render :template => '/home/sellers/developers'
  end

  def sellers_law_firms
  	render :template => '/home/sellers/law_firms'
  end

  def sellers_reit_funds
  	render :template => '/home/sellers/reit_funds'
  end

  def sellers_nfp
  	render :template => '/home/sellers/non_profit'
  end
  
  def sellers_title_companies
  	render :template => '/home/sellers/title_companies'
  end
  
  def auctions
  	render :template => 'home/auctions/auctions'
  end

  def auctions_real_estate
  	render :template => 'home/auctions/real_estate'
  end
  
  def sponsors
  	render :template => 'home/sponsors'
  end
  
  def contact_us
  	render :template => 'home/contact_us'
  end
  
  # Tools
  def tools
  	render :template => 'home/utility/tools'
  end
  
  # Brochure
  def brochure_request
  	render :template => 'home/utility/brochure_request'
  end


end
