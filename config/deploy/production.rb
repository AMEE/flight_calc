# Domain and Application settings
set :application, "cnn-carbon-calculator"
set :domain, "cnn.dynamic50.com"

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
