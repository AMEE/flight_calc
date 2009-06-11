# Output Formatting
def green(str); puts "\e[32m#{str}\e[0m"; end
def red(str); puts "\e[33m#{str}\e[0m"; end
def debug(str); puts "\e[35mDEBUG: #{str}\e[0m"; end


namespace :amee do
   desc "Import Airports from Amee"
   task :import_airports => :environment do
     puts "--- Deleting Old Airport Data"
     Airport.delete_all
     
     puts "--- Asking Amee for the airport data"
     session = AmeeConnection.session
     airport_category = session.get_data_category("/data/transport/plane/generic/airports/all/countries", :query => {:itemsPerPage => 4000})
     airports = airport_category.data_items
     airports.each do |airport_item|
       puts "--- Adding Airport"
       item_values = airport_item.item_values
       # country
       country = item_values.find{|i| i.name == "Country"}
       # airport name
       airport_name = item_values.find{|i| i.name == "Airport name"}
       # iata code
       iata_code = item_values.find{|i| i.name == "IATA code"}
       # full name
       full_name = item_values.find{|i| i.name == "Full name"}
       # latitude
       latitude = item_values.find{|i| i.name == "Latitude"}
       # longitude
       longitude = item_values.find{|i| i.name == "Longitude"}
       Airport.create!(:country => country.value, :name => airport_name.value,
        :iata_code => iata_code.value, :full_name => full_name.value, :latitude => latitude.value,
        :longitude => longitude.value)
       puts "-- finished adding airport Country: #{country.value} NAME #{airport_name.value}"
     end
     puts "-- We are done!"
   end
end