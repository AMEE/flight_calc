# Approach taken from facebookers logging
# need to really look into what we want from Amee logging
require 'benchmark'
module Amee
  @@logger = nil
  def self.logger=(logger)
    @@logger = logger
  end
  def self.logger
    @@logger
  end

  module Logging
    def self.log_amee_api(method, parser_name, path, options)
      message = method 
      dump = format_da_dump(parser_name, path, options)
      if block_given?
        result = nil
        seconds = Benchmark.realtime { result = yield }
        log_info(message, dump, seconds) 
        result
      else
        log_info(message, dump) 
        nil
      end
    rescue Exception => e
      exception = "#{e.class.name}: #{e.message}: #{dump}"
      log_info(message, exception)
      raise
    end
    
    def self.format_da_dump(parser_name, path, options)
      "AMEE: PARSER NAME: #{parser_name} PATH: #{path} OPTIONS: #{options.inspect}"
    end
    
    def self.log_info(message, dump, seconds = 0)
      return unless Amee.logger
      log_message = "#{message} (#{seconds}) #{dump}"
      Amee.logger.info(log_message)
    end
    
  end  
end