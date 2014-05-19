class ParentsController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @parents = Parent.order("lastName ASC").paginate(page: params[:page])
  end

  def new
  	@parent = Parent.new
    @sports = Sport.all
    respond_to do |format|
      format.html {render :new}
      format.js
    end
  end

  def create
  	@parent = Parent.new(parent_params)
    Rails.logger.info(params)
  	if @parent.save
      sign_in @parent
  		flash[:success] = "Welcome to Your Youth Sports Profile!".html_safe
  		redirect_to @parent
  	else
  		render 'new'
  	end
  end

  def show
  	@parent = Parent.find(params[:id])
    @children = @parent.children
    @sports = Sport.all
    @parent_comments = @parent.parent_comments.paginate(page: params[:page])
  end

  def edit
    @current_user = current_user
    respond_to do |format|
      format.html{
        @parent = Parent.find(params[:id])
      }
      format.js
    end
  end

  def update
    @current_user = current_user
    respond_to do |format|
      if @current_user.update_attributes(parent_params)
        format.js { render js: "window.location = '/parents/#{@current_user.id}'" }
      else
        Rails.logger.info(@current_user.errors.messages.inspect)
        format.js
      end
    end
  end

  def destroy
    @parent = Parent.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to parents_url
  end

######## Before Filters ################

def correct_user
  @user = Parent.find(params[:id])
  redirect_to(root_url) unless current_user?(@user)
end

######## PRIVATE ################

  private

    def parent_params
    	params.require(:parent).permit(:firstName, :lastName, :email, :phone, 
    					:password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
