class SocialNetworkLoginController < ApplicationController

  def login_facebook
    url = "https://www.facebook.com/dialog/oauth?client_id=#{FACEBOOK_KEY}&scope=email&redirect_uri=#{ROOT_URL}login/facebook/callback"
    redirect_to url
  end

  def login
   status,subscriber=SocialNetworkingLogin.facebook_network_callback(params)
   @user = User.find_by_email_id(subscriber['email']) || User.create(:email_id=>subscriber['email'])
   set_login_details
   redirect_to :controller=>:pagenates,:action=>:index
  end

  
end
