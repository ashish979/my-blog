class ArticlesController < ApplicationController
 before_action :confirm_loggin_in,:set_variables
 	
	def index
		@search = Article.search do
			search_variable = params[:search]
			fulltext "#{search_variable}"
		end
		@articles = @search.results		
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)		
		if @article.save
			flash[:notice] = "new article created"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
	  @article = Article.find(params[:id])	 
	  if @article.update(article_params)
	    redirect_to @article
	  else
	    render 'edit'
	  end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

	def set_variables
		if session[:username]
			@user = User.find_by(:username => session[:username])
		end
	end
	private
	def article_params
		params.require(:article).permit(:title, :text)
	end
	
	def confirm_loggin_in
		unless session[:username]
			flash[:notice] = "Please login!!"
			redirect_to login_users_path
			return false
		else
			return true
		end
	end
end
