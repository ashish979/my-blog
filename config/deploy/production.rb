set :branch, "master"
set :rails_env, 'production'
set :deploy_to, "/var/www/#{application}_#{ rails_env }"
set :ssh_options, { :forward_agent => true, :port => 13813 }
role :web, "103.245.13.29"       
role :app, "103.245.13.29"                          
role :db,  "103.245.13.29", :primary => true 
	