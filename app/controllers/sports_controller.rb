class SportsController < ApplicationController

  def index
    @sports = Sport.all
  end

  def new
    @sport = Sport.new
  end

  def create
    @sport = Sport.new(sport_params)
    if !params[:coed].nil? or params[:coed] == "true" or params[:coed] == "false"
      @sport.coed = to_boolean(params[:coed])
    end
    if @sport.save
      flash[:success] = " #{@sport.name} #{@sport.min_age}-#{@sport.max_age} Created "
    else
      flash[:danger] = "Error creating sport"
    end
    Rails.logger.info(@sport.errors.full_messages)
    redirect_to sports_url
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def sport_params
      params.require(:sport).permit(:name, :season_start, :season_end, :open_to, :coed, :min_age, :max_age)
    end

end
