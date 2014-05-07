module SessionsHelper
	def sign_in(user)
		remember_token = Parent.new_remember_token
		cookies.permanent[:remember_token] = remember_token # cookies = stored unhashed
		user.update_attribute(:remember_token, Parent.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end	

	def current_user=(user)
		@current_user = user
	end

	def current_user
		remember_token = Parent.digest(cookies[:remember_token])
		if @current_user.nil?
			@current_user = Parent.find_by(remember_token: remember_token)
		else
			@current_user
		end
	end

	def sign_out
		current_user.update_attribute(:remember_token, Parent.digest(Parent.new_remember_token))

		cookies.delete(:remember_token)
		self.current_user = nil
	end
end
