module Amee
  class Config
    class << self
      attr_accessor :configuration
      
      def defaults
        @defaults ||= {
          :cache => true,
          :cache_store => Moneta::Memory, 
          :expires_in => 60*60*24,
          :server => "stage.amee.com",
          :auth_path => "/auth",
          :accept => "application/json",
          :logging => true
        }
      end
    
      # yields the configuration
      #
      # @example
      #   Amee::Config.set |config| do
      #     config[:server] = "dev.aimee.com"
      #   end
      #
      # @return nil
      def set
        @configuration ||= defaults
        yield @configuration
        nil
      end
    

      def key?(key)
        (@configuration ||= defaults).key?(key)
      end
    
      # Retrieve the value from the config
      #
      # @param [Object] key the key to return the value from 
      #
      # @return [Object]
      def [](key)
        (@configuration ||= defaults)[key]
      end
    
      # sets the value of the config
      def []=(key, val)
        (@configuration ||= defaults)[key] = val
      end
    
      # deletes the value from the config
      def delete(key)
        (@configuration ||= defaults).delete(key)
      end
      
    end
    
  end # Config
end # Amee