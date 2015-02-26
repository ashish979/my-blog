class WelcomeController < ApplicationController
  before_action :set_variables

  def index
  end

  def set_variables
		if session[:username]
			@user = User.find_by(:username => session[:username])
		end
	end
end
