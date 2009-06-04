set :application, "cnn-carbon-calculator"
set :domain, "cnn.dynamic50.com"

namespace :deprec do
  namespace :memcache do
    set :memcache_ip, '127.0.0.1'
    set :memcache_port, 11211
    set :memcache_memory, 64
  end
end

   
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed

set :gems_for_project, %w(treetop json_pure nokogiri faker rack_hoptoad haml mislav-will_paginate rack hookercookerman-amee httparty wycats-moneta) # list of gems to be installed

role :app, "cnn.dynamic50.com"
role :web, "cnn.dynamic50.com"
role :db,  "cnn.dynamic50.com", :primary => true
role :mail, "cnn.dynamic50.com"
role :sphinx, "cnn.dynamic50.com"


namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    db_config = <<-EOF
    production:    
      adapter: mysql
      encoding: utf8
      username: root
      password: 
      database: cnn_carbon_production
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
  end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.passenger.restart
  end
  
  
  task :tail_log do
    run "tail -f #{shared_path}/log/production.log"
  end
end
