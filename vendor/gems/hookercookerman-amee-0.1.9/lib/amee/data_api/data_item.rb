require "amee/data_api/data_item_value"
require "amee/data_api/item_definition"
module Amee
  module DataApi
    class DataItem
      require "amee/data_api/data_category"
      include Amee::Model
      self.path_prefix  = "/data"

          
      attr_accessor :start_date, :end_date, :label, :choices, :kg_c_o2_per_k_wh, :source, :amount_per_month, :amount
      list_populators :item_values => {:class => Amee::DataApi::DataItemValue}      
      item_populators :data_category => {:class => Amee::DataApi::DataCategory},
                        :item_definition => {:class => Amee::DataApi::ItemDefinition}
      
      def co2_unit
        amount["unit"] if amount
      end

      def co2_value
        amount["value"] if amount
      end
      
      def populate!
        session.api_call(:get, "data.item", self.full_path) do |response|
          populate_from_hash!(response)
          self
        end
        @lazy_loaded = true
      end
      
      def kg_co2_per_kwh
        kg_c_o2_per_k_wh
      end
    
    end
  end
end