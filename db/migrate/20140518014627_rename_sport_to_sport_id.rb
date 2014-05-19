class RenameSportToSportId < ActiveRecord::Migration
  def change
  	rename_column :teams, :sport, :sport_id
  end
end
