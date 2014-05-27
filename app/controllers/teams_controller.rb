class TeamsController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :must_be_admin, only: [:unassign, :assign, :assign_complete]

	def index
		@sports = Sport.all
	end

	def new
		must_be_admin
		@team = Team.new
		@sports = Sport.all
		@sport_names = []
		@sports.each do |sport|
			@sport_names.push(sport.name)
		end
	end

	def create		
		@team = Team.new(team_params)
		Rails.logger.info(params)
		if @team.save
			flash[:success] = "Team successfully created!"
			redirect_to current_user
		else
			flash[:danger] = "Error creating team #{@team.errors.full_messages}"
			redirect_to new_team_path
		end
	end

	def show
		store_delete_loc
		@team = Team.find(params[:id])
		@children = @team.children
		@comments = Message.where(receiver_type: "Team", receiver_id: @team.id).paginate(page: params[:page], per_page: 25)
		@comment = current_user.messages.build if signed_in?			
	end

	def edit
		must_be_admin
		@team = Team.find(params[:id])	
	end

	def update
		@team = Team.find(params[:id])
		if @team.update_attributes(team_params)
			flash[:success] = "Team successfully updated!"
			redirect_to @team
		else
				flash[:danger] = "Error creating team #{@team.errors.full_messages}"
			redirect_to edit_team_path
		end
	end

	def destroy
		team = Team.find(params[:id])
		flash[:success] = "#{team.name} delete successfully!"
		team.destroy
		redirect_to teams_path
	end

	def assign
		@team = Team.find(params[:id])
		@sport = @team.sport
		@children = get_all_eligible(@team)
	end

	def assign_complete
		@team = Team.find(params[:team_id])
		@child = Child.find(params[:child_id])
		if !@team.nil? and !@child.nil? and !@child.assigned?(@team.sport)
			Rails.logger.info(@child.firstName)
			@child.teams << @team
			Rails.logger.info(@child.teams)
		end
		respond_to do |format|
			format.js
		end
	end

	def post_message
		@user = current_user
		@comment = @user.messages.build(message_params)
		if !Team.find(params[:id]).nil?
			@comment.receiver_id = params[:id]
			@comment.receiver_type = "Team"
		end
		if !@comment.save
			@errors = @comment.errors
		end
	end

	def unassign
		child = Child.find(params[:child_id])
		team = Team.find(params[:id])
		if child.teams.destroy(team)
			flash[:success] = "#{child.firstName} removed."
		else
			flash[:danger] = "Unable to remove player."
		end
		redirect_to team
	end

	def get_all_eligible(team)
		children = Child.all
		sport = team.sport
		eligible = []
		children.each do |child|
			if child.registered?(sport) and child.eligible?(sport, team)
				eligible.push(child)
			end
		end
		return eligible
	end

	private

		def team_params
			params.require(:team).permit(:name, :sport_id, :min_age, :max_age, :max_players, :image_url)
		end

		def must_be_admin
			if !current_user.admin?
				flash[:danger] = "You must be an admin to access the requested page."
				redirect_to current_user
			end
		end

		def message_params
			params.require(:message).permit(:content, :sender_id, :sender_type)
		end

end
