require "amee/data_api/data_item"
require "amee/data_api/item_definition"
module Amee
  module DataApi
    class DataCategory
      include Amee::Model
      self.path_prefix = "/data"
    
      list_populators :data_categories => {:class => Amee::DataApi::DataCategory}, 
                      :data_items => {:class => Amee::DataApi::DataItem}
      item_populators :item_definition => {:class => Amee::DataApi::ItemDefinition}
      
      # essentially the parent category                
      attr_accessor :data_category, :pager
      
      # we can only drill with a data_category that has data_items
      #
      # @param [Hash] selection of what we wish to drill down
      #
      # @return [Amee::DataApi::Drill] if we can drill down we get a drill object
      # @return [nil] if we cannot drill then nil will be the name of the day
      def drill(selections = {})
        if can_drill?
          session.drill(self.full_path, :selections => selections)
        end
      end
      
      # when drilling the end goal is to get a data_item
      # if we can get a data_item it is given if not nil will be
      # return
      # @param [Hash] selection of what we wish to drill down
      # @return [Amee::DataApi::DataItem]
      # @return [Nil] if could not get the uid of the data_category ie not drilled far enough
      def drill_to_data_item(selection = {})
        if drilled = drill(selection)
          if data_item_uid = drilled.data_item_uid
            session.get_data_item("#{self.full_path}/#{data_item_uid}")
          end
        end
      end
      
      def can_drill?
        !data_items.empty?
      end

      # lets delagate this one
      def drill_down
        item_definition && item_definition.drill_down
      end
      
      def paginate_data_items(options = {})
        data_items = WillPaginate::Collection.create(
          options[:page] || 1,
          options[:per_page] || 10,
          options[:total] || self.pager["items"]
        ) do |pager|
          pager.replace(self.data_items || [])
        end
      end
      
      def populate!
        session.api_call(:get, "data.category", self.full_path) do |response|
          populate_from_hash!(response)
          self
        end
        @lazy_loaded = true
      end
      
    end
  end
end