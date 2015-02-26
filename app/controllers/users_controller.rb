class UsersController < ApplicationController
	before_action :confirm_loggin_in,
	:except => [:login, :attempt_login, :logout, :new, :create]

  def new
  	@user = User.new
  end

  def create
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  	user = User.new(:username => params[:user][:username], :password => params[:user][:password], :email => params[:user][:email])
    if user.save
      redirect_to(:action => 'login')
    else
      redirect_to '/signup'
    end
  end

  def login
  	@user = User.new
  end

  def attempt_login
  	user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:username] = params[:user][:username]
      if user.admin
        redirect_to admin_users_path
      else
        redirect_to  welcome_index_path
      end      
    else
      flash[:notice] = "incorrect username/password"
      redirect_to '/users/login'      
    end

  end

  def logout
  	session[:username] = nil
    redirect_to '/users/login'
  end

  def admin
    @user = User.where(:admin => false)
  end

  def show
    @user = User.find_by_id(params[:username])
  end

  def modify
    user = User.find_by(:username => params[:username])
    if params[:author]
      user.update(:author => true)
    else
      user.update(:author => false)
    end

    if params[:editor]
      user.update(:editor => true) 
    else
      user.update(:editor => false)                  
    end

    if params[:commenter]
      user.update(:commenter => true) 
    else
      user.update(:commenter => false) 
    end
    if params[:viewer]
      user.update(:viewer => true)  
    else                
      user.update(:viewer => false) 
    end
    if params[:destroyer]
      user.update(:destroyer => true)     
    else             
      user.update(:destroyer => false) 
    end
    redirect_to(:action => 'admin')

  end

  private
  def confirm_loggin_in
  	unless session[:username]
  		redirect_to(:action => 'login')
      flash[:notice] = "Please login!!"
      return false
  	else
      return true
  	end
  end

end
