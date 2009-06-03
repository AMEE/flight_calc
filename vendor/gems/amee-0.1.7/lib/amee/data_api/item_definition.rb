module Amee
  module DataApi
    class ItemDefinition
      include ::Amee::Model
      path_prefix = "/data"
      
      attr_accessor :drill_down
      
    end
  end
end