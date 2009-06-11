require "amee/data_api/data_category"
require "amee/data_api/data_item_value"
module Amee
  module ProfileApi
    class ProfileItem
      include Amee::Model
      self.path_prefix = "/profiles"
      
      attr_accessor :end, :amount, :data_item, :profile, :valid_from, :start_date, :end_date
      attr_accessor :data_item_label, :data_item_uid, :total_amount
      
      list_populators :item_values => {:class => Amee::DataApi::DataItemValue}   
      item_populators :data_category => {:class => Amee::DataApi::DataCategory},
                      :item_definition => {:class => Amee::DataApi::ItemDefinition}
        
      
      # @todo This currently will not work as profile data_item brings back a profile_category
      #       How stupid is that!
      def self.create(session, path, data_item_uid, fields ={})
        hash = session.create_profile_item(path, data_item_uid, {:fields => fields, :hash_response => true})
        self.from_hash(hash, session)
      end
      
      def update(fields = {})
        session.api_call(:put, "profile_item", self.full_path, 
          :query => fields.merge({:representation => true})) do |response|
          populate_from_hash!(response)
          self
        end
      end
      
      def destroy
        session.delete_profile_item(self.full_path)
      end
      
      def co2_unit
        amount["unit"]
      end
      
      def co2_value
        amount["value"]
      end
      
      def profile_uid
        profile["uid"]
      end
      
      def full_path
        "#{self.class.path_prefix}/#{profile_uid}" + resource_path
      end
      
      def populate!
        session.api_call(:get, "profile_item", self.full_path) do |response|
          populate_from_hash!(response)
          self
        end
        @lazy_loaded = true
      end
      
    end
  end
end