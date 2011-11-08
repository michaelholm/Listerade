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
  		# save the search
  		# json = params.to_json
  		# ss = SavedSearch.find_or_create_by_query(json)
  		# ss.user = current_user
  		# ss.save
  	end
  end
end