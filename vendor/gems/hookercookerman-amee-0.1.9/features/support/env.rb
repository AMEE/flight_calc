$:.unshift(File.dirname(__FILE__) + '/../../lib')
require 'amee'

gem 'cucumber'
require 'cucumber'
gem 'rspec'
require 'spec'

# yes I know not meant to have this but I need the auth_token
# stubbed so there ok deal with it
require "spec/mocks"


gem "fakeweb"
require "fakeweb"

# amee fixtures or canned responses
AMEE_FIXTURE_PATH = File.dirname(__FILE__) + "/amee"

# dont want any real 
FakeWeb.allow_net_connect = false



