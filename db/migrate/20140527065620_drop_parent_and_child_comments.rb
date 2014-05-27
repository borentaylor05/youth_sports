class DropParentAndChildComments < ActiveRecord::Migration
  def change
  	drop_table :parent_comments
  	drop_table :child_comments
  	drop_table :coach_comments
  end
end
