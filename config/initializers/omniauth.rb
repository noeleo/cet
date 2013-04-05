
Rails.application.config.middleware.use OmniAuth::Builder do
#provider :password

  provider :developer
  # example for 3rd party:

  #provider :cas, :host => 'https://auth.berkeley.edu/cas/login'
  provider :cas, :host => 'auth.berkeley.edu/cas/login'

  # look here for more info: https://github.com/dlindahl/omniauth-cas 
  # provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']

end

