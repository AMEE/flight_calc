# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # before_filter :authenticate_global
  self.allow_forgery_protection = false
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  protected
  def authenticate_global
    if ['production'].include?(Rails.env)
      authenticate_or_request_with_http_basic do |user_name, password|
        user_name == "admin" && password == "cnn"
      end
    end
  end
end
