class PostsController < ApplicationController
	before_filter :must_be_signed_in, only: [:new, :create]

	def new
		@post = Post.new
	end

	def index
		@posts = Post.all
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = session[:id]
		if @post.save
			flash[:success] = "Post added"
			redirect_to posts_path
		else
			flash.now[:danger] = "Post could not be added"
			render 'new'
		end
	end

	private

		def must_be_signed_in
			redirect_to root_url unless logged_in?
		end

		def post_params
			params.require(:post).permit(:content)
		end
end
