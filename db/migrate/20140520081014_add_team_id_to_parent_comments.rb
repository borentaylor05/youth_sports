class AddTeamIdToParentComments < ActiveRecord::Migration
  def change
  	add_column :parent_comments, :team_id, :integer
  end
end
