class ChildrenController < ApplicationController

	before_action :signed_in_user

	def index
		@children = current_user.children.all	
	end

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

	def register
    	@children = current_user.children.all
    	if params[:sport].nil?
    		flash[:info] = "Select a sport to register for..."
    		redirect_to sports_path
    	else
    		@sport = Sport.find(params[:sport])
    	end
  	end

  	def register_complete
  		register_params
  		child = Child.find(params[:child_id])
  		sport = Sport.find(params[:sport_id])
  		if !child.nil? and !sport.nil?
  			flash[:success] = "Child registered!"
  			child.sports << sport
  			redirect_to current_user
  		else
  			flash[:danger] = "Error Registering"
  			redirect_to children_register_path
  		end
  	end

	private

		def child_params
			params.require(:child).permit(:lastName, :firstName, :birthday, :physicalComplete, :parent_id)
		end

		def register_params
			params.permit(:child_id, :sport_id)
		end

end
