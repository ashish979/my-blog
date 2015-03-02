
set :application, "my-blog"
set :repository,  "https://github.com/ashish979/my-blog.git"
set :scm, :git
set :deploy_via, :remote_cache
set :server, :passenger
set :use_sudo, false
set :user, "redmine"
set :stages, %w(production staging)
set :keep_releases, 5

default_run_options[:pty] = true

namespace :deploy do
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
 
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  desc "Deploy with migrations"
  task :long do
    transaction do
      update_code
      web.disable
      symlink
      migrate
    end
    restart
    web.enable
    cleanup
  end

  desc "Run cleanup after long_deploy"
  task :after_deploy do
    cleanup
  end

  after "deploy:restart"
  
end
