class ApplicationController < ActionController::Base
  protect_from_forgery


  USER_NAME, PASSWORD = "breos", "breos"
  before_filter :authenticate_testing
  
  def authenticate_testing
   if Rails.env.development?
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
   end
 end
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
  
  def is_number?(object)
    true if Float(object) rescue false
  end
  
end
