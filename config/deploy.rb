# RVM
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
set :rvm_type, :user

load 'deploy/assets'

# Using asset pipeline
#set :normalize_asset_timestamps, false

# Bundler
require "bundler/capistrano"

# General
set :application, "wiggler"
set :user, "mikey"
set :keep_releases, 3

set :deploy_to, "/var/www/#{application}"

set :use_sudo, false

# Git
set :scm, :git
set :repository,  "https://github.com/mikeyhogarth/wiggler.git"
set :branch, "master"

# VPS
role :web, "wiggler.nomelette.co.uk"
role :app, "wiggler.nomelette.co.uk"
role :db,  "wiggler.nomelette.co.uk", :primary => true

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :custom do
  task :symlinks, :roles => :app do
    logger.info "updating database config"
    logger.info "removing original"
    run %Q{rm #{release_path}/config/database.yml}
    logger.info "symlinking in production config"
    run %Q{ln -nfs #{shared_path}/database_config/database.yml #{release_path}/config/database.yml}
  end
end

after "deploy:update", "deploy:cleanup" 
before "deploy:assets:precompile", "custom:symlinks"

# FAYE server
set :faye_pid, "#{deploy_to}/shared/pids/faye.pid"
set :faye_config, "#{deploy_to}/current/private_pub.ru"
namespace :faye do
  desc "Start Faye"
  task :start do
    run "cd #{deploy_to}/current && bundle exec rackup #{faye_config} -s thin -E production -D --pid #{faye_pid}"
  end
  
  desc "Stop Faye"
  task :stop do
    run "kill `cat #{faye_pid}` || true"
  end
end

before 'deploy:update_code', 'faye:stop'
after 'deploy:finalize_update', 'faye:start'

