class RenameColumnCoachIdToCoachId < ActiveRecord::Migration
  def change
  	rename_column :comments, :coachID, :coach_id
  end
end
