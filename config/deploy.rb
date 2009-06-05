require 'deprec'
require 'capistrano/ext/multistage'
set :stages, %w(staging production)
set :default_stage, "production"

# Settings for server
set :ruby_vm_type,      :ree        # :ree, :mri
set :web_server_type,   :apache     # :apache, :nginx
set :app_server_type,   :passenger  # :passenger, :mongrel
set :db_server_type,    :mysql      # :mysql, :postgresql, :sqlite

# Settings for Git Repository
set :repository,  "git@github.com:hookercookerman/cnn-airport-cal.git"
set :scm, "git"
set :git_enable_submodules,1
set :user, "deploy"
set :password, "80shour2"
set :git_shallow_clone, 1 # We don't need the full history
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

# Some custom tasks
namespace :rake do
  task :show_tasks do
    run("cd #{deploy_to}/current; /usr/local/bin/rake -T RAILS_ENV=#{stage}")
  end
  
  task :install_gems, :roles => :app  do
    run("cd #{deploy_to}/current; /usr/local/bin/rake gems:install RAILS_ENV=#{stage}")
  end
  
  task :rake_amee_import_airports do
    run("cd #{deploy_to}/current; /usr/local/bin/rake amee:import_airports RAILS_ENV=#{stage}")
  end
  
  task :index_sphinx do
    run("cd #{deploy_to}/current; /usr/local/bin/rake thinking_sphinx:index RAILS_ENV=#{stage}")
  end
  
  task :configure_sphinx do
    run("cd #{deploy_to}/current; /usr/local/bin/rake thinking_sphinx:configure RAILS_ENV=#{stage}")
  end
  
  
end

# Memcached
namespace :deprec do
  namespace :memcache do
    set :memcache_ip, '127.0.0.1'
    set :memcache_port, 11211
    set :memcache_memory, 64
  end
end

# Gems and packages to install
# set :packages_for_project, %w(libmagick9-dev imagemagick libfreeimage3) # list of packages to be installed
set :gems_for_project, %w(treetop json_pure nokogiri faker rack_hoptoad haml mislav-will_paginate rack hookercookerman-amee httparty wycats-moneta) # list of gems to be installed
