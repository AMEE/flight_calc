# Domain and Application settings
set :application, "cnn-carbon-calculator"
set :domain, "192.168.1.72"

role :app, "192.168.1.72"
role :web, "192.168.1.72"
role :db,  "192.168.1.72", :primary => true
role :mail, "192.168.1.72"
role :sphinx, "192.168.1.72"




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

# Restart passenger on deploy
desc "Restarting mod_rails with restart.txt"
task :before_restart, :except => { :no_release => true } do
  run "cd #{current_path}; #{sudo} rake gems:install RAILS_ENV=staging"
  run "cd #{current_path}; rake gems:unpack:dependencies RAILS_ENV=staging"
  run "cd #{current_path}; rake gems:build RAILS_ENV=staging"  
  run "touch #{current_path}/tmp/restart.txt"
end