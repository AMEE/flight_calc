require 'net/http'
module Amee
  class Service
    include HTTParty
    format :json
    
    attr_accessor :auth_token
    
    def initialize(auth_token)
      @auth_token = auth_token
    end
    
    def post(method, path, options = {})
      perform_request(:post, method, full_path(path), options)
    end
    
    def get(method, path, options = {})
      perform_request(:get, method,full_path(path), options)
    end
    
    def put(method, path, options = {})
      perform_request(:put, method, full_path(path), options)
    end
    
    def delete(method, path, options = {})
      perform_request(:delete, method, full_path(path), options)
    end
    
    def self.auth_token(username, password, path)
      response = Net::HTTP.post_form(
        URI.parse("http://#{Amee::Config[:server]}#{path}"),
        {'username'=> username, 'password'=>password}
      )
      response['authToken']
    rescue Errno::ECONNREFUSED, SocketError
      raise Amee::Session::ServerNotFound, "Amee Server could not be found"
    end
    
    private
    # we want to attach the authToken to the headers of the request 
    # and then check the status code
    def perform_request(type, method, path, options)
      attach_headers(options)
      response = self.class.send(type, path, options)
      check_response(response.code)
      Parser.parse(method, response)
    rescue Errno::ECONNREFUSED, SocketError
      raise Amee::Session::ServerNotFound, "Amee Server could not be found"
    end
    
    def attach_headers(options)
      (options[:headers] ||= {}).merge!(
        {
          "authToken" => @auth_token, 
          'Accept' => options[:accept] || Amee::Config[:accept]
        }
      )
    end
    
    # using the config instead of base_uri as onces its set its set
    # Also https as well if needed
    # same for the format but I dont care about XML
    def full_path(path)
      "http://#{Amee::Config[:server]}#{path}"
    end
    
    # checking the status code of the response; if we are not authenticated
    # then authenticate the session
    #
    # @raise [Amee::PermissionDenied] if the status code is 403
    # @raise [Amee::UnAuthorized] if a auth_token could not be generated
    # @raise [Amee::SessionExpired] if a we get a 401
    # @raise [Amee::UnknownError] if we get something strange
    def check_response(code)
      case code
        when 200, 201
          true
        when 403
          raise Amee::Session::PermissionDenied.new("You do not have permission to perform the requested operation")
        when 401
          raise Amee::Session::Expired.new("Session has expired")
        when 404
          raise Amee::Session::NotFound.new("resource was not found")
        else
          raise Amee::Session::UnknownError.new("super strange type unknown error")
      end
    end
      
  end
end