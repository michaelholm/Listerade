class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def dashboard
    @user = current_user   #User.find(params[:id])
    # If this show page is only for the currently logged in user change it to @user = current_user
  end
  
  def add_fave(new_fave)
  	if user_signed_in?
  		current_user.fave_listings << new_fave
  		current_user.save
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