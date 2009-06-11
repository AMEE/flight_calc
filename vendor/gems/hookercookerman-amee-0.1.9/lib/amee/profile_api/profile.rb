require "amee/profile_api/profile_category"
require "amee/profile_api/profile_item"
module Amee
  module ProfileApi
    class Profile
      include ::Amee::Model
      self.path_prefix = "/profiles"
      
      attr_accessor :total_amount
      list_populators :profile_categories => {:class => Amee::ProfileApi::ProfileCategory}
      item_populators :data_category => {:class => Amee::DataApi::DataCategory}
         
      def self.create(session)
         self.from_hash(session.new_profile, session)
       end
      
      def create_profile_item(path_or_category, data_item_uid, params = {})
        path = full_path + (path_or_category.is_a?(String) ? "#{path_or_category}" : "#{path_or_category.full_path}")
        session.create_profile_item(path, data_item_uid, params)
      end
      
      def get_profile_item(path, options = {})
        session.get_profile_item((full_path + path), options)
      end
      
      def get_profile_category(path, options = {})
        session.get_profile_category((full_path + path), options)
      end
      
      def update_profile_item(path, fields)
        session.update_profile_item((full_path + path), :fields => fields)
      end
 
      def destroy
        session.delete_profile(self.uid)
      end
      
      def full_path
        "#{self.class.path_prefix}/#{self.uid}"
      end
      
      def lazy_loaded
        true
      end
      
    end
  end
end