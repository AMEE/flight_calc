# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

# We dont have prod password and shit just yet!
# ::Amee::Config.set do |config|
#   config[:username] = "hookercookerman"
#   config[:password] = "553eaec5"
#   config[:server] = "stage.amee.com"
# end
# 


# ActionController::Base.asset_host = Proc.new { |source|
#      if source.starts_with?('/images')
#        "http://i.cdn.turner.com/cnn/.element/img/2.0/misc/intl/carbon.calc/1.0"
#      elsif source.starts_with?('/stylesheets')
#        "http://i.cdn.turner.com/cnn/.element/css/2.0/misc/intl/carbon.calc/1.0"
#      elsif source.starts_with?('/javascripts')
#        "http://i.cdn.turner.com/cnn/.element/js/2.0/misc/intl/carbon.calc/1.0"
#      end
# }

::Amee::Config.set do |config|
  config[:username] = "cnn"
  config[:password] = "aa221361"
  config[:server] = "live.amee.com"
end

CNN_AMEE_PROFILE = "9D7C819AB003"