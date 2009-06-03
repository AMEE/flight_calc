set :stages, %w(staging production)

set :default_stage, "staging"
require 'capistrano/ext/multistage'




set :repository,  "git@github.com:hookercookerman/cnn-airport-cal.git"
set :scm, "git"
set :git_enable_submodules,1
set :user, "deploy"
set :password, "80shour2"
set :git_shallow_clone, 1 # We don't need the full history
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true



# Some weird glitch with -u app
set :runner, nil

namespace :deploy do
  task :tail_log do
    run "tail -f #{shared_path}/log/production.log"
  end
end
