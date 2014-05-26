class SessionsController < ApplicationController
	def new
		
	end

	def create
		parent = Parent.find_by_email(params[:session][:email].downcase)
		respond_to do |format|
			if parent && parent.authenticate(params[:session][:password])
				sign_in parent
				url = redirect_back_or "parents/#{parent.id}"
				format.js {render js: "window.location = '#{url}' "}
			else
				format.js
			end	
		end
	end

	def create_child_session
		child = Child.find_by(username: params[:session][:username])
		if child and child.authenticate(params[:session][:password])
			child_sign_in child
			redirect_to child
		else
			flash[:danger] = "Wrong username/password combo"
			redirect_to sign_in_path
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
