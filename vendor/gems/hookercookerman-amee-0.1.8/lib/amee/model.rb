# Approach taken from facebooker
module Amee
  module Model
    def self.included(base)
      base.extend ClassMethods
      base.__send__(:attr_writer, :session)
      base.__send__(:attr_accessor, :path)
      base.__send__(:attr_accessor, :uid)
      base.__send__(:attr_accessor, :name)
      base.__send__(:attr_accessor, :modified)
      base.__send__(:attr_accessor, :created)
      base.__send__(:attr_accessor, :resource_path)
      base.__send__(:attr_accessor, :lazy_loaded)
      
      base.class_eval do
        class  << base; attr_reader :lazy_populators end
        class  << base; attr_accessor :path_prefix end
        path_prefix = ""
      end
    end
    
    module ClassMethods

      def from_hash(hash, session = nil)
        instance = new(hash, session)
        yield instance if block_given?
        instance
      end
      
      def item_populators(hash)
        @lazy_populators ||= [] << hash.keys
        populator_item_getter(hash.keys)
        hash.each_pair do |key, value|
          
          define_method("#{key}=") do |definition|
            if session && !definition.nil?
              if self.resource_path
                definition["resource_path"] = self.resource_path+"/#{definition["path"]}" 
              end
              instance_variable_set("@#{key}", value[:class].new(definition, session))
            end 
          end
          
        end
      end
      
      def list_populators(hash)
        @lazy_populators ||= [] << hash.keys
        populator_lists_getter(hash.keys)
        hash.each_pair do |key, value|
          
          define_method("#{key}=") do |list|
            instance_variable_set("@#{key}", list.map do |item|
              if self.resource_path
                item["resource_path"] = self.resource_path+"/#{item["path"]}" 
              end
              value[:class].new(item, session)
            end) if session
          end
            
        end
      end
      
      def populator_lists_getter(pops)
        pops.each do |symbol|
           define_method(symbol) do
             if !populated? && self.resource_path
               populate! 
             end
             instance_variable_get("@#{symbol}") || []
           end
         end
      end
      
      def populator_item_getter(pops)
        pops.each do |symbol|
           define_method(symbol) do
             if !populated? && self.resource_path
               populate! 
             end
             instance_variable_get("@#{symbol}")
           end
         end
      end
      
    end # ClassMethods
    
      def session
        @session || (raise "Must bind this object to a Amee session before using")
      end

      def initialize(hash = {}, session = nil)
        @session = session
        populate_from_hash!(hash)
      end
      
      def full_path
        self.class.path_prefix + resource_path
      end
      
      def populated?
        @populated && lazy_loaded
      end
      
      def populate!
        raise ::NotImplementedError, "#{self.class} included me and has not overriden me"
      end
      
      def populate_from_hash!(hash)
        unless hash.nil? || hash.empty?
          populate_paths(hash["resource_path"], hash["path"])
          hash.each do |key, value|
            set_attr_method = "#{Amee::Utils::String.snake_case(key)}="
            if !value.nil? && respond_to?(set_attr_method)
              self.__send__(set_attr_method, value) 
            else
              # attempt to set attribute basically
            end
          end      
          @populated = true
        end
      end
      
      # we want the resource paths populated along with the path
      # before we populate any other attribute as
      # they may use these attributes
      def populate_paths(resource_path, path)
        self.resource_path, self.path = resource_path, path
      end
            
  end
end