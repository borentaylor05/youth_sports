class RenameColumnParentIdToparentId < ActiveRecord::Migration
  def change
  	rename_column :comments, :parentID, :parent_id
  end
end
