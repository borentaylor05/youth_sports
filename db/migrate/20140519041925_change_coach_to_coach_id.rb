class ChangeCoachToCoachId < ActiveRecord::Migration
  def change
  	rename_column :teams, :coach, :coach_id
  end
end
