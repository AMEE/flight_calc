module Amee
  module DataApi
    class DrillDown
      include ::Amee::Model
      self.path_prefix  = "/data"
      
      # choices are an array of hashes with keys "value" and "name"
      # same for the selections as well
      attr_accessor :choice_name, :choices, :selections
      item_populators :data_category => {:class => Amee::DataApi::DataCategory}
      
      def data_item_uid
        if uid_found?
          choices.first["value"]
        end
      end
      
      def uid_found?
        choice_name == "uid"
      end
      
      def lazy_loaded
        true
      end
      
    end
  end
end