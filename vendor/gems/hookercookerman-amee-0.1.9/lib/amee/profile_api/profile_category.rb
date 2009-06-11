require "amee/profile_api/profile_item"
require "amee/data_api/data_category"
module Amee
  module ProfileApi
    class ProfileCategory
      include ::Amee::Model
      self.path_prefix = "/profiles"
      
      
      attr_accessor :profile, :total_amount, :pager
      
      list_populators :profile_items => {:class => Amee::ProfileApi::ProfileItem},
                      :profile_categories => {:class => Amee::ProfileApi::ProfileCategory}
                      
      item_populators :data_category => {:class => Amee::DataApi::DataCategory}
              
      def populate!
        session.api_call(:get, "profile.category", self.full_path) do |response|
          populate_from_hash!(response)
          self
        end
        @lazy_loaded = true
      end
      
      def profile_uid
        profile["uid"]
      end
      
      def total_co2_unit
        total_amount["unit"]
      end
      
      def total_co2_value
        total_amount["value"]
      end
      
      def full_path
        "#{self.class.path_prefix}/#{profile_uid}" + resource_path
      end
      
      def paginate_profile_items(options = {})
        profile_items = WillPaginate::Collection.create(
          options[:page] || 1,
          options[:per_page] || 10,
          options[:total] || self.pager["items"]
        ) do |pager|
          pager.replace(self.profile_items || [])
        end
      end
      
    end
    
  end
end