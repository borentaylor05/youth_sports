class ParentCommentsController < ApplicationController

	before_action :signed_in_user

	def create
		@parent_comment = current_user.parent_comments.build(comment_params)
		if @parent_comment.save
			flash[:success] = "Comment Saved"
			redirect_to root_url
		else
			flash[:danger] = "Comment can't be blank"
			redirect_to root_url
		end
	end

	def destroy
	end

	private
		
		def comment_params
			params.require(:parent_comment).permit(:body)
		end

end