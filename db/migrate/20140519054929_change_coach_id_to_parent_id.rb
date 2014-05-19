class ChangeCoachIdToParentId < ActiveRecord::Migration
  def change
  	rename_column :teams, :coach_id, :parent_id
  end
end
