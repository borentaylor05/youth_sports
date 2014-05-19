class AddMaxPlayersToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :max_players, :integer
  end
end
