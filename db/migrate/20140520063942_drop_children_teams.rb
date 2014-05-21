class DropChildrenTeams < ActiveRecord::Migration
  def change
  	drop_table :children_teams
  end
end
