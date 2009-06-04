set :application, "cnn-carbon-calculator"
set :domain, "cnn.dynamic50.com"

set :repository,  "git@github.com:hookercookerman/cnn-airport-cal.git"
set :scm, "git"
set :git_enable_submodules,1
set :user, "deploy"
set :password, "80shour2"
set :git_shallow_clone, 1 # We don't need the full history
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

   
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed

set :gems_for_project, %w(treetop nokogiri faker rack_hoptoad haml mislav-will_paginate rack hookercookerman-amee httparty wycats-moneta) # list of gems to be installed

role :app, "cnn.dynamic50.com"
role :web, "cnn.dynamic50.com"
role :db,  "cnn.dynamic50.com", :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.app.restart
  end
end

namespace :deploy do
  task :tail_log do
    run "tail -f #{shared_path}/log/production.log"
  end
end
