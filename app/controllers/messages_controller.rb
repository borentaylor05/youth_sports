class MessagesController < ApplicationController
	before_action :signed_in_user

	def create
		@message = current_user.messages.build(message_params)
		if @message.save
			flash[:success] = "Comment Saved"
			redirect_to root_url
		else
			flash[:danger] = "Comment can't be blank"
			redirect_to root_url
		end
	end

	def destroy
		comment = Message.find(params[:id])
		comment.destroy
		flash[:success] = "Comment deleted!"
		redirect_to session[:delete_url]
	end

	private
		
		def message_params
			params.require(:parent_comment).permit(:body)
		end
end
