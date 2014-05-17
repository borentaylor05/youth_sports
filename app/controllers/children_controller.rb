class ChildrenController < ApplicationController

	before_action :signed_in_user

	def new
		@child = Child.new
	end

	def create
		@child = current_user.children.build(child_params)
		if !params[:physicalComplete].nil?
			@child.physicalComplete = to_boolean(params[:physicalComplete])
		end
		if @child.save
			flash[:success] = " #{@child.firstName} added successfully! "
			redirect_to current_user
		else
			flash[:danger] = " Error Adding child.  All fields are required. "
			redirect_to new_child_path
		end
	end

	def destroy
		@child = Child.find(params[:id]).destroy
		flash[:success] = "Child successfully removed"
		redirect_to current_user
	end

	private

		def child_params
			params.require(:child).permit(:lastName, :firstName, :birthday, :physicalComplete, :parent_id)
		end

end
