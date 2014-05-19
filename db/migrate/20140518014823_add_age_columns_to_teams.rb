class AddAgeColumnsToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :min_age, :date
  	add_column :teams, :max_age, :date
  end
end
