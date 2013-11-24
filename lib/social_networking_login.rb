#require 'linkedin'
#require 'oauth/consumer'
require 'json'
require 'rest_client'
require 'uri'
require 'rss'

include ApplicationHelper

class SocialNetworkingLogin

  def self.facebook_network_callback(params,options={})
    if (params[:error] and params[:error] != '')
      @status ="There was an error trying to login to your Facebook account, please try again."
    elsif (params[:code] and params[:code] != '')
      code = params[:code]
      url = "https://graph.facebook.com/oauth/access_token?client_id=#{FACEBOOK_KEY}&redirect_uri=#{ROOT_URL}login/facebook/callback&client_secret=#{FACEBOOK_SECRET}&code=#{code}"
      r = RestClient.get url
      access_token = r.to_s.split("access_token=")[1]
      graph_url = "https://graph.facebook.com/me?access_token=#{URI.escape(access_token)}&fields=id,name,first_name,middle_name,last_name,gender,locale,languages,link,username,age_range,third_party_id,installed,timezone,updated_time,verified,bio,birthday,cover,currency,devices,education,email,hometown,interested_in,location,picture,political,favorite_athletes,favorite_teams,picture,quotes,relationship_status,religion,security_settings,significant_other,video_upload_limits,website,work,friends"
      r = RestClient.get graph_url
      user = JSON.parse(r.to_s)
      Rails.logger.info "===================User==#{user}"
      @status = "true"
    else
      @status ="false"
    end
    return @status , user
  end

  def self.linkedin_network_callback(session,params,site)
    @site=site
   client = LinkedIn::Client.new(getLinkedinApiKey(),getLinkedinSecret() )
   if !params[:oauth_verifier].blank?
   if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile_old = client.profile
    LinkedIn.configure do |config|
      config.token = atoken
      config.secret = asecret
       config.default_profile_fields =['id','first-name','last-name','maiden-name','formatted-name','phonetic-first-name','phonetic-last-name','formatted-phonetic-name','headline','industry','distance','current-status','current-status-timestamp','current-share','num-connections','num-connections-capped','summary','specialties','positions','picture-url','site-standard-profile-request','public-profile-url','email-address','last-modified-timestamp','proposal-comments','associations','interests','publications','patents','languages','skills','certifications','educations','courses','volunteer','three-current-positions','three-past-positions','num-recommenders','recommendations-received','mfeed-rss-url','following','job-bookmarks','suggestions','date-of-birth','member-url-resources','related-profile-views','phone-numbers','bound-account-types','im-accounts','main-address','twitter-accounts','primary-twitter-account','group-memberships']
    end
    @profile = client.profile
    return @profile , @status=true
   end
  else
    return nil , @status=false
  end


 def self.create_image_for_social_media(user,image_url)
    Rails.logger.info "=============subscriber==============profile====image======#{user.inspect}======="
    image = open (image_url)
    @image = Image.new(:image_name=>"#{user.first_name}_""#{user.provider_id}",:alt_tag=>"#{user.first_name}_""#{user.provider_id}",:extension=>"jpeg")
    @image_detail=ImageDetail.new()
    @image.image_details << @image_detail
    tmp_path=@image_detail.generate_image_path(image,"#{user.first_name}_""#{user.provider_id}")
    original_tmp_path = `mv "#{tmp_path.first}"  "#{tmp_path.first}.jpeg"`
    @image_detail.update_attributes(:image_path => "#{tmp_path.first}.jpeg")
    if @image.save
      @image.status = "Active"
      @image.default_version_id = @image.image_details.where(:logical_name => "original").first.id
      @image.original_version_id = @image.image_details.where(:logical_name => "original").first.id
      @image.thumbnail_version_id = @image.get_image('120', '120', 'square').id
      @image.save(:validate => false)
      user.profile_picture({:image_id=>(@image.id)})
      Rails.logger.info "=============subscriber==============profile=========#{user.profile_image.inspect}============"
    return @image
    end
 end

end
