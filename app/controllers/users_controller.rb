class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def dashboard
    @user = current_user   #User.find(params[:id])
    # If this show page is only for the currently logged in user change it to @user = current_user
  end
  
  # toggle a favorite property
  def toggle_favorite
    if user_signed_in?
    	@user = current_user
    	
    	# toggle. so, if it's there, remove it
    	if @user.favorite_listings.include?(params[:listing_id]) then
  			@user.favorite_listings.delete(params[:listing_id])
  			message = 'removed'
  		else
  			# else, we'll add it
  			@user.favorite_listings << params[:listing_id] unless @user.favorite_listings.include?(params[:listing_id])
  			message = 'added'		
  		end
  		
  		@user.save
  	end
	
	render :text => message
  
  end
  
  # regular add, though toggle is best for general use
  def add_to_favorites
  	if user_signed_in?
  		@user = current_user
  		@user.favorite_listings << params[:listing_id] unless @user.favorite_listings.include?(params[:listing_id])
  		@user.save
  		
  		render :nothing => true
  	end
  end

  # regular remove, though toggle is best for general use
  def remove_from_favorites
  	if user_signed_in?
  		@user = current_user
  		if @user.favorite_listings.include?(params[:listing_id]) then
  			@user.favorite_listings.delete(params[:listing_id])
  			@user.save
  		end
  		
  		render :nothing => true
  	end
  end

  def save_search()
  	if user_signed_in?
  	
  		# all searches have location key, so only save search if it contains location in params
  		if params.has_key?('location')
  			search = SavedSearch.new
  			search.location = params[:location]
  		
			if params.has_key?('bathrooms') then search.bathrooms = params[:bathrooms].to_f end
		  	if params.has_key?('bedrooms') then search.bedrooms = params[:bedrooms].to_i end
		  	if params.has_key?('minyear') then search.built_min = params[:minyear].to_i end
		  	if params.has_key?('maxyear') then search.built_max = params[:minyear].to_i end
		  	if params.has_key?('price_low') then search.price_low = params[:price_low].to_i end
		  	if params.has_key?('price_high') then search.price_high = params[:price_high].to_i end
		  	if params.has_key?('zipcode') then search.zip = params[:zipcode] end
		  	if params.has_key?('property_type') then search.property_type = params[:property_type] end
			# add in search results count
	  	
	  		@user = current_user
	  		@user.saved_searches << search
			search.save
			
			message = 1
		else
			message = 0
		end
  	end
  	
  	render :text => message	
  
  end
  
  def saved_search
  	search = SavedSearch.where(:id => params[:id]).first
  	
  	qs = "location=#{CGI::escape(search.location)}"
  	qs << "&bathrooms=#{search.bathrooms}" unless search.bathrooms.empty? 
  	qs << "&bedrooms=#{search.bedrooms}" unless search.bedrooms.empty? 
  	
  	puts CGI::escape(qs)
  	
  	redirect_to "/find?#{qs}"
  end
  
end