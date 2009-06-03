module Amee
  module Utils
    class String
      def self.snake_case(string)
        return string.downcase if string =~ /^[A-Z]+$/
        string.gsub(/([A-Z]+)(?=[A-Z][a-z]?)|\B[A-Z]/, '_\&') =~ /_*(.*)/
          return $+.downcase
      end
    end 
  end
end