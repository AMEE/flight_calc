begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end


$TESTING=true
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'amee'


require "fakeweb"
FakeWeb.allow_net_connect = false

# amee fixtures or canned responses
AMEE_FIXTURE_PATH = File.dirname(__FILE__) + "/../features/support/amee"
