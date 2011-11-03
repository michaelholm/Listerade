class UsersController < ApplicationController
  def dashboard
    @user = current_user   #User.find(params[:id])
    # If this show page is only for the currently logged in user change it to @user = current_user
  end
end