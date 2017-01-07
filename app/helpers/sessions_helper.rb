module SessionsHelper
	def log_in(user)
		session[:id] = user.id
		@current_user = user
	end

	def log_out
		session.delete(:id)
		forget
		@current_user = nil
	end

	def remember(user)
		user.remember
		cookies.permanent[:remember_token] = user.remember_token
		cookies.permanent.signed[:id] = user.id
	end

	def forget
		@current_user.forget
		cookies.delete(:remember_token)
		cookies.delete(:id)
	end

	def current_user
		if session[:id]
			@current_user = User.find(session[:id])
		elsif cookies.signed[:id]
			user ||= User.find(cookies.signed[:id])
			if user && user.authenticated?(cookies[:remember_token])
				log_in(user)
				@current_user = user
			end
		end
	end

	def current_user=(user)
		@current_user = user
	end

	def logged_in?
		!(current_user.nil?)
	end
end
