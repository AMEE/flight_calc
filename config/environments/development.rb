# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false
# 
::Amee::Config.set do |config|
  config[:username] = "hookercookerman"
  config[:password] = "553eaec5"
end

CNN_AMEE_PROFILE = "241EE37F2D38"

ActionController::Base.asset_host = Proc.new { |source|
     if source.starts_with?('/images')
       "http://i.cdn.turner.com/cnn/.element/img/2.0/misc/intl/carbon.calc/1.0"
     elsif source.starts_with?('/stylesheets')
       "http://i.cdn.turner.com/cnn/.element/css/2.0/misc/intl/carbon.calc/1.0"
     elsif source.starts_with?('/javascripts')
       "http://i.cdn.turner.com/cnn/.element/js/2.0/misc/intl/carbon.calc/1.0"
     end
}