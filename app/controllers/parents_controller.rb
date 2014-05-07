class ParentsController < ApplicationController
  def new
  	@parent = Parent.new
  end

  def create
  	@parent = Parent.new(parent_params)
  	if @parent.save
      sign_in @parent
  		flash[:success] = "Welcome to Your Youth Sports Profile!".html_safe
  		redirect_to @parent
  	else
  		flash[:danger] = "Error Creating Account! The email provided is already registered."
  		render 'new'
  	end
  end

  def show
  	@parent = Parent.find(params[:id])
  	@children = Child.all
  end

  private

  def parent_params
  	params.require(:parent).permit(:firstName, :lastName, :email, :phone, 
  					:password, :password_confirmation)
  end

end
