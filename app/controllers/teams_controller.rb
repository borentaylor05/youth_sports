class TeamsController < ApplicationController
	before_action :signed_in_user, only: [:edit, :update]
	before_action :must_be_admin, only: [:unassign, :assign, :assign_complete]
	before_action :get_image
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
		@url = get_image
		@team = Team.find(params[:id])
		@children = @team.children
		@comments = @team.parent_comments
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

	def get_image
		if request.original_url.include? 'teams' and !params[:id].nil?
			team = Team.find(params[:id])
			sport = team.sport;
			case sport.name
			when "Football"
				@image = "football.jpg"
			when "Soccer"
				@image = "soccer.jpg"
			end			
		end
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

end
