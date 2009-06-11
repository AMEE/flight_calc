require "amee/data_api/item_value_definition"
module Amee
  module DataApi
    class DataItemValue
      include ::Amee::Model
      self.path_prefix  = "/data"
    
      attr_accessor :display_name, :description, :value, :display_path, :unit, :per_unit, :data_item
      item_populators :item_value_definition => {:class => Amee::DataApi::ItemValueDefinition}
      
      
      def lazy_loaded
        true
      end
        
    end
  end
end