$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "rubygems"
begin
  gem "json"
  require "json/ext"
rescue LoadError
  gem "json_pure"
  require "json/pure"
end

gem  "httparty", "~>0.4.3"
require "httparty"

gem "wycats-moneta", "~>0.5.0"
require "moneta"
require "moneta/memory"

require "amee/utils/string"
require "amee/config"
require "amee/logging"
require "amee/service"
require "amee/session"
require "amee/parser"
require "amee/model"
require "amee/data_api/data_item"
require "amee/data_api/data_category"
require "amee/data_api/item_definition"
require "amee/data_api/data_item_value"
require "amee/data_api/drill_down"
require "amee/data_api/item_value_definition"
require "amee/data_api/value_definition"
require "amee/profile_api/profile_item"
require "amee/profile_api/profile_category"
require "amee/profile_api/profile"

module Amee
  VERSION = '0.1.9'
end