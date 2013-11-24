class ApplicationController < ActionController::Base
 before_filter :current_user
  protect_from_forgery

 def current_user 
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  logger.info "===============current_user===#{@current_user.inspect}========#{session[:user_id].inspect}"
 end

  def set_login_details
   session[:user_id] = @user
   cookies[:user_email]={ :value => @user.email_id, :expires => 1.hour.from_now }
  end

end
