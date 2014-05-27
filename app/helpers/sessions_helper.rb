module SessionsHelper
	def sign_in(user)
		remember_token = Parent.new_remember_token
		cookies.permanent[:remember_token] = remember_token # cookies = stored unhashed
		cookies.permanent[:user_type] = "parent"
		user.update_attribute(:remember_token, Parent.digest(remember_token))
		self.current_user = user
	end

	def child_sign_in(user)
		remember_token = Child.new_remember_token
		cookies.permanent[:remember_token] = remember_token # cookies = stored unhashed
		cookies.permanent[:user_type] = "child"
		user.update_attribute(:remember_token, Child.digest(remember_token))
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end	

	def current_user=(user)
		@current_user = user
	end

	def current_user?(user)
		user == current_user
	end

	def current_user
		if cookies[:user_type] == "child"
			type = Child
		else
			type = Parent
		end
		remember_token = type.digest(cookies[:remember_token])
		if @current_user.nil?
			@current_user = type.find_by(remember_token: remember_token)
		else
			@current_user
		end
	end

	def sign_out
		if current_user.is_a?(Child)
			current_user.update_attribute(:remember_token, Child.digest(Child.new_remember_token))
		else
			current_user.update_attribute(:remember_token, Parent.digest(Parent.new_remember_token))
		end
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	def redirect_back_or(default)
		url = session[:return_to] || default
		session.delete(session[:return_to])
		return url
	end

	def store_location
		session[:return_to] = request.url if request.get?
	end

	def store_delete_loc
		session[:delete_url] = request.url if request.get?
	end

	def signed_in_user
		unless signed_in?
		  store_location
		  redirect_to signin_url, notice: "Please Sign In" unless signed_in?
		end
	end

	def to_boolean(str)
		str.downcase == 'true'
	end

	def verify_parent
		if current_user.is_a?(Child)
			flash[:danger] = "Only parents have access to the requested page"
			redirect_to current_user
		end
	end


end
