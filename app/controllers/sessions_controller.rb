class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def update
		@user = User.find_by(email: params[:session][:email].downcase)
		if @user && @user.authenticate(params[:session][:password])
			log_in(@user)
			redirect_to root_path
		else
			flash.now[:danger] = "Invalid username/password combination"
			debugger
			render 'new'
		end
	end

	def destroy
		log_out if logged_in?
		redirect_to root_path
	end
end
