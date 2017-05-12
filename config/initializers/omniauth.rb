require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do  
  # use OmniAuth::Strategies::OpenID, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp")
  # provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'

  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :token_params => {
    :parse => :json
  }
end
