class Airport < ActiveRecord::Base
  
  # Airport dont move that often so distance will remain the same
  def self.distance(origin_airport, destination_airport, return_flight = false)
    Rails.cache.fetch([origin_airport, destination_airport,"distance-#{return_flight}"]) do
      distance = Haversine.distance_between(origin_airport, destination_airport)
      return_flight ? distance*2 : distance
    end
  end
  
  def display
    "#{self.name}"
  end
  
  # Sphinx
  define_index do
    indexes :country
    indexes :name
    indexes :full_name
    indexes :iata_code
  end
end