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

  def self.import_from_amee!
    puts "--- Deleting Old Airport Data"
    Airport.delete_all
    puts "--- Asking Amee for the airport data"     
    c = AMEE::Rails.connection(:enable_debug => true)
    c.timeout = 60
    page = 1
    max_pages = 1
    while page <= max_pages
      airport_category = AMEE::Data::Category.get(c, "/data/transport/plane/generic/airports/all/countries", :items_per_page => 100, :page => page)
      airport_category.items.each do |i|
        puts "--- Adding Airport"
        Airport.create!(:country => i[:country], :name => i[:airportName],
          :iata_code => i[:IATACode], :full_name => i[:fullName], :latitude => i[:latitude],
          :longitude => i[:longitude])
        puts "-- finished adding airport Country: #{i[:country]} NAME #{i[:airportName]}"
       end
       page += 1
       max_pages = airport_category.pager.last_page
     end
     puts "-- We are done!"
   end
   
end
