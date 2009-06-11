require "amee/data_api/value_definition"
module Amee
  module DataApi
    class ItemValueDefinition
      include Amee::Model
      self.path_prefix = "/data"
    
      attr_accessor :from_profile, :from_data
      item_populators :value_definition => {:class => Amee::DataApi::ValueDefinition}
      
      def lazy_loaded
        true
      end
    
    end
  end
end