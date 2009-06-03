module Amee
  class Session
    
    class Expired < StandardError; end
    class UnAuthorized < StandardError; end
    class NotAuthenticated < StandardError; end
    class PermissionDenied < StandardError; end
    class NotFound < StandardError; end
    class ServerNotFound < StandardError; end
    class UnknownError < StandardError; end
    attr_accessor :auth_token, :cache, :service
    
    def self.create(username = nil, password = nil)
      username ||= Amee::Config[:username]
      password ||= Amee::Config[:password]
      raise ArgumentError unless !username.nil? && !password.nil?
      new(username, password)
    end
    
    def initialize(username, password, authenticate = true)
      @username = username
      @password = password
      @cache = create_cache_store if caching?
      authenticate! if authenticate
    end
    
    # We create a cache store vie using the config cache_store and parameters if 
    # they exist; Moneta Stores are only supported
    # @return [Moneta::Store]
    def create_cache_store
      @cache = Amee::Config[:cache_store].send(:new, *Amee::Config[:cache_store_parameters] || nil)
    end
    
    # @return [Boolean] are we caching?
    def caching?
      Amee::Config[:cache]
    end
    
    def authenticate!
      @auth_token = nil
      unless @auth_token = Amee::Service.auth_token(@username, @password, Amee::Config[:auth_path])
        raise Amee::Session::UnAuthorized.new "Please provide your correct username and password. "
      end
      service.auth_token = @auth_token
    end
    
    def authenticated?
      !@auth_token.nil?
    end
    
    def service 
      if authenticated?
        @service ||= Amee::Service.new(@auth_token)
      else
        raise Amee::Session::NotAuthenticated.new "Session is not authenticated"
      end
    end
    
    # we send the service the HTTP method along with the parser we want to use 
    # and the path 
    #
    # @param [Symbol] method the HTTP method that we want to use
    # @param [String] parser_name the parser name we want to use
    # @param [String] path 
    # @param [Hash] options 
    # @param [Boolean] use_auth_token NOTE not using this right now
    def api_call_without_logging(method, parser_name, path, options, use_auth_token =true, &proc)
      result = service.send(method, parser_name, path, options)
      result = yield result if block_given?
      store_resource(path,result, options||{}) if method == :get && caching?
      result
    end
    
    
    # this over long ie bad method is to either get the cache for a api call
    # or actually call the amee api; if the session has expired we will try 
    # to get a new one
    def api_call(method, parser_name, path, options ={}, use_auth_token =true, &proc)
      if (cache = @cache[cache_key(path, options[:query] || {})]) && caching?
        return cache
      else
        attempts = 0
        begin
          if Amee::Config[:logging]
            Amee::Logging.log_amee_api(method, parser_name, path, options) do
              api_call_without_logging(method, parser_name, path, options, use_auth_token =true, &proc)
            end
          else
            api_call_without_logging(method, parser_name, path, options, use_auth_token =true, &proc)
          end
        rescue Amee::Session::Expired
          attempts +=1 
          if attempts < 2
            self.authenticate!
            retry
          else
            raise
          end
        end
      end
    end
        
    # @return [Amee::DataApi::DataCategory]
    def get_data_category(path, options = {})
      api_call(:get, "data.category", path, options) do |response|
        Amee::DataApi::DataCategory.from_hash(response, self) do |data_category|
          data_category.lazy_loaded = true
        end
      end
    end
    
    # @return [Amee::DataApi::DrillDown]
    def drill(path, options = {})
      api_call(:get, "data.drill", "#{path}/drill", :query => options[:selections]) do |response|
        Amee::DataApi::DrillDown.from_hash(response, self)
      end
    end
    
    # @return [Amee::DataApi::DataItem]
    def get_data_item(path, options = {})
      api_call(:get, "data.item", path, options) do |response|
        Amee::DataApi::DataItem.from_hash(response, self) do |data_item|
          data_item.lazy_loaded = true
        end
      end
    end
    
    # @return [Amee::DataApi::DataItemValue]
    def get_data_item_value(path, options ={})
      api_call(:get, "data.item_value", path, options) do |response|
        Amee::DataApi::DataItemValue.from_hash(response, self)
      end
    end
    
    # @return [Amee::ProfileApi::Profile]
    def create_profile
      @cache.clear
      api_call(:post, "create.profile", "/profiles", :query => {:profile => true}) do |response|
        Amee::ProfileApi::Profile.from_hash(response, self)
      end
    end
    
    # @return [Amee::ProfileApi::Profile]
    def get_profile(uid)
      api_call(:get, "get.profile", "/profiles/#{uid}") do |response|
        Amee::ProfileApi::Profile.from_hash(response, self)
      end
    end
    
    # @return [Amee::ProfileApi::ProfileItem]
    def update_profile_item(path, options = {})
      @cache.clear
      api_call(:put, "profile_item", path, :query => {:representation => options[:representation] || true}.merge(options[:fields])) do |response|
        Amee::ProfileApi::ProfileItem.from_hash(response, self)
      end
    end
    
    # @return [String] locaion of the new resource
    def create_profile_item(path, uid, options = {})
      @cache.clear
      api_call(:post, "profile_item", path, 
        :query => {:dataItemUid => uid, :representation => "full"}.merge(options[:fields])) do |response|
          return response if options[:hash_response]
          Amee::ProfileApi::ProfileItem.from_hash(response, self)
        end
    end
    
    # does not create a profile object compared to the create version
    # @return [Hash]
    def new_profile
      @cache.clear
      api_call(:post, "create.profile", "/profiles", :query => {:profile => true}) do |response|
        response
      end
    end
    
    # @return [Boolean]
    def delete_profile(uid)
      @cache.clear
      api_call(:delete, "delete.profile", "/profiles/#{uid}") do |response|
        true
      end
    end
    
    # @return [Boolean]
    def delete_profile_item(path)
      @cache.clear
      api_call(:delete, "delete.profile_item", path) do |response|
        true
      end
    end
    
    # @return [Amee::ProfileApi::ProfileCategory]
    def get_profile_category(path, options = {})
      api_call(:get, "profile_category", path, options) do |response|
        Amee::ProfileApi::ProfileCategory.from_hash(response, self) do |profile_category|
          profile_category.lazy_loaded = true
        end
      end
    end
    
    # @return [Amee::ProfileApi::ProfileItem]
    def get_profile_item(path, options = {})
      api_call(:get, "profile_item", path, options) do |response|
        Amee::ProfileApi::ProfileItem.from_hash(response, self) do |profile_item|
          profile_item.lazy_loaded = true
        end
      end
    end
    
    # @return [Array[Amee::Profile]]
    def profiles
      api_call(:get, "profiles", "/profiles") do |response|
        response.map do |profile|
          Amee::ProfileApi::Profile.from_hash(profile, self) unless profile.empty?
        end
      end
    end
    
    # @return [Hash]
    def get_raw(path, options = {})
      api_call(:get, "raw", path)
    end
    
    # @param [String] path the path of the resource
    # @param [Hash] cache_options this is the cache options
    def store_resource(path, result, options = {})
      key = cache_key(path, options[:query] ||{})
      cache_options = options[:cache] || {}
      @cache.store(key, result, :expires_in => cache_options[:expires_in] || Amee::Config[:expires_in])
    end
    
    protected
    def cache_key(path, params = {})
      path + params.map { |key,value| "#{key}=#{value}" }.join('/')
    end
      
  end
end