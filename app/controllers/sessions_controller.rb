class SessionsController < ApplicationController
	def new
		
	end

	def create
		@p = "Poo"
		parent = Parent.find_by_email(params[:session][:email].downcase)
		respond_to do |format|
			if parent && parent.authenticate(params[:session][:password])
				sign_in parent
				format.js {render js: "window.location = '/parents/#{parent.id}'"}
			else
				format.js
			end	
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
