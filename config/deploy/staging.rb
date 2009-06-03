set :application, "cnn_carbon_staging"

set :deploy_to, "/opt/apps/#{application}"

role :app, "cnn-carbon.dynamic50.com"
role :web, "cnn-carbon.dynamic50.com"
role :db,  "cnn-carbon.dynamic50.com", :primary => true

set :branch, "master"

set :keep_releases, 2

set :rails_env, "staging"


set :domain, "cnn-carbon.dynamic50.com"
set :server_name, "cnn-carbon.dynamic50.com"


namespace :deploy do
  desc "Create the database yaml file"
  task :after_update_code do
    db_config = <<-EOF
    staging:    
      adapter: mysql
      encoding: utf8
      username: root
      password: 
      database: cnn_carbon_staging
    EOF
    
    put db_config, "#{release_path}/config/database.yml"
  end
  
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
   run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
   desc "#{t} task is a no-op with mod_rails"
   task t, :roles => :app do ; end
  end
end

# grant all on lgloop_production.* to 'dynamic50'@'localhost' identified by 'hd63gd73f9';

