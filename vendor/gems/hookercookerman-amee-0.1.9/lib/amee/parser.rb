# Approach taken from facebooker
module Amee
  class Parser
    def self.parse(method, data)
      parser = Parser::PARSERS[method]
      parser.process(
        data
      )
    end
  end
  
  class DataCategory < Parser
    def self.process(data)
      category = data["dataCategory"]
      parent_category = data["dataCategory"]["dataCategory"] if data["dataCategory"]
      pager = {"pager" => data["children"].delete("pager")}
      categories = {"data_categories" => data["children"].delete("dataCategories")}
      data_items = {"data_items" => data["children"]["dataItems"].delete("rows")} if data["children"]["dataItems"]
      category.merge(categories).
      merge(data_items).
      merge(pager).
      merge({"resource_path" => data["path"]})
    end
  end
  
  class DataItem < Parser
    def self.process(data)
      data_item = data["dataItem"]
      item_values = {"item_values" => data["dataItem"].delete("itemValues")}
      data_item.merge(item_values).
      merge({"choices" => data["userValueChoices"]["choices"]}).
      merge({"amount" => data["amount"]}).
      merge({"resource_path" => data["path"]})
    end
  end
  
  class DataItemValue < Parser
    def self.process(data)
      data_item_value = data["itemValue"]
      data_item_value.merge({"resource_path" => data["path"]})
    end
  end
  
  class Drill < Parser
    def self.process(data)
      choices = {"choices", data["choices"].delete("choices")}
      data.merge(choices).merge({"choice_name" => data["choices"].delete("name")})
    end
  end
  
  class Profiles < Parser
    def self.process(data)
      data["profiles"]
    end
  end
  
  class ProfileCategory < Parser
    def self.process(data)
      data.merge({"resource_path" => data["path"]})
    end
  end
  
  class ProfileItem < Parser
    def self.process(data)
      profile_item = data["profileItem"]
      item_values = {"item_values" => data["profileItem"].delete("itemValues")}
      profile_item.merge(item_values).merge({"resource_path" => data["path"]})
    end
  end
  
  class CreateProfile < Parser
    def self.process(data)
      data["profile"].
      merge({"resource_path" => data["path"]})
    end
  end
  
  class UpdateProfile < Parser
    def self.process(data)
      data["profile"].
      merge({"resource_path" => data["path"]})
    end
  end
  
  class DeleteProfile < Parser
    def self.process(data)
      data
    end
  end
  
  class GetProfile < Parser
    def self.process(data)
      data["profile"].merge({"profile_categories" => data["profileCategories"]}).
      merge({"profile_items" => data["profileItems"]}).
      merge({"total_amount" => data["totalAmount"]}).
      merge({"resource_path" => data["path"]})
    end
  end
  
  class CreateProfileItem < Parser
    def self.process(data)
      data.merge({"resource_path" => data["path"]})
    end
  end
  
  class DeleteProfileItem < Parser
    def self.process(data)
      data
    end
  end
  
  
  class Raw < Parser
    def self.process(data)
      data
    end
  end
  
  class Parser
    PARSERS = {
      'data.category' => DataCategory,
      'data.item' => DataItem,
      "data.item_value" => DataItemValue,
      "raw" => Raw,
      "profiles" => Profiles,
      "create.profile" =>CreateProfile,
      "update.profile" => UpdateProfile,
      "delete.profile" => DeleteProfile,
      "create.profile_item" => CreateProfileItem,
      "profile_category" => ProfileCategory,
      "profile_item" => ProfileItem,
      "delete.profile_item" => DeleteProfileItem,
      "get.profile" => GetProfile,
      "profile.category" => ProfileCategory,
      "data.drill" => Drill
    }
  end
end