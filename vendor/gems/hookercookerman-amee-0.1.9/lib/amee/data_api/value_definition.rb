module Amee
  module DataApi
    class ValueDefinition
      include ::Amee::Model
      self.path_prefix = "/data"
    
      attr_accessor :value_type, :description
    end
  end
end