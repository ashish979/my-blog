# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'simple_blog_application'
set :repo_url, 'https://github.com/ashish979/my-blog.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
 set :deploy_to, '/var/www/simple_blog_application'

# Default value for :scm is :git
 set :scm, :git

 set :user, "redmine"

 set :scm_passphrase, "payu@123"

 set :use_sudo, false

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
 set :rails_env, "production"

 set :deploy_via, :remote_cache
# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

   desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

 desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

	after "deploy", "deploy:symlink_config_files"
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

end
