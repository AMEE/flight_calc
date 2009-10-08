namespace :amee do
   desc "Import Airports from Amee"
   task :import_airports => :environment do
     Airport.import_from_amee!
   end
end
