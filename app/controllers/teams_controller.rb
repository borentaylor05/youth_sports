class TeamsController < ApplicationController

	def index
	end

	def new
		if !current_user.admin?
			flash[:danger] = "You must be an admin to access the requested page."
			redirect_to current_user
		end
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

	private

		def team_params
			params.require(:team).permit(:name, :sport_id, :min_age, :max_age, :max_players)
		end

end
