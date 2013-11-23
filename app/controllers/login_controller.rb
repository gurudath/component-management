class LoginController < ApplicationController

  def index
   
  end

  def set_login_details
   session[:user_id] = @user
   cookies[:user_email]={ :value => @user.email_id, :expires => 1.hour.from_now }  
  end
  

  def verify_login
   if (!params[:email].blank? and !params[:password].blank?)
    @user=User.where(:password =>params[:password],:email_id=>params[:email]).first
     if (!@user.blank?)
       set_login_details
       redirect_to :controller=>:pagenates,:action=>:index
     else
      flash[:notice]="Invalid Username And Password"
      render :template=>'/login/index'
    end
   else
   flash[:notice]="Invalid Username And Password"
   render:template=>'/login/index'
   end
  end

  def logout
   session[:user_id] = nil
   reset_session 
   cookies[:user_email]={ :value => nil }
   redirect_to :action=>"index"
  end

 
end
