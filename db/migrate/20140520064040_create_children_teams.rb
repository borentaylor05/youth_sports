class CreateChildrenTeams < ActiveRecord::Migration
  def change
  	create_table :children_teams, id: false do |t|
  		t.integer :child_id
  		t.integer :team_id
  	end
  	add_index :children_teams, [:child_id, :team_id]
  end
end
