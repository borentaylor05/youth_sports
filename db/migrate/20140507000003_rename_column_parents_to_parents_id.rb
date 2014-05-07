class RenameColumnParentsToParentsId < ActiveRecord::Migration
  def change
  	rename_column :children, :parent, :parent_id
  end
end
